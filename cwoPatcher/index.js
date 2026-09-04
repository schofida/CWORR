/* global ngapp, xelib, registerPatcher, patcherUrl */

registerPatcher({
    info: info,

    gameModes: [xelib.gmSSE, xelib.gmTES5],
    settings: {

        label: 'Civil War Overhaul Patcher',

        templateUrl: `${patcherUrl}/partials/settings.html`,

        controller: function($scope) {
            const cwoFileName = 'Civil War Overhaul.esp';
            const cwoFile = xelib.FileByName(cwoFileName);
            const skyrimFile = xelib.FileByName('Skyrim.esm');
            let cwoLCharSoldierImperial = xelib.GetElement(cwoFile, "CWOLCharSoldierImperial");
            xelib.GetOverrides(cwoLCharSoldierImperial).forEach(override => {
                if (xelib.GetFileName(xelib.GetElementFile(override)) !== 'zPatch.esp') {
                    cwoLCharSoldierImperial = override;
                }
            });
            let cwoLCharSoldierSons = xelib.GetElement(cwoFile, "CWOLCharSoldierSons");
            xelib.GetOverrides(cwoLCharSoldierSons).forEach(override => {
                if (xelib.GetFileName(xelib.GetElementFile(override)) !== 'zPatch.esp') {
                    cwoLCharSoldierSons = override;
                }
            });
            const LCharSoldierImperial = xelib.GetElement(skyrimFile, "0001FC5B");
            const LCharSoldierSons = xelib.GetElement(skyrimFile, "0001FC5C");

            let patcherSettings = $scope.settings.cwoPatcher;

            if (!patcherSettings.troopConfig[0]) {
                patcherSettings.troopConfig[0] = {};
            }
            if (!patcherSettings.troopConfig[1]) {
                patcherSettings.troopConfig[1] = {};
            }

            $scope.troopConfig = [];
            $scope.activeTab = 0;
            $scope.activeFile = 0;

            $scope.selectTab = function(file, tab) {
                $scope.activeTab = tab;
                $scope.activeFile = file;                
            }

            $scope.onChange = function(file, troopKey, reference, count, level) {
                if (count === null || !(typeof level === 'number' && isFinite(level))) {
                    return;
                }
                patcherSettings.troopConfig[$scope.activeTab][troopKey] = {
                    reference,
                    count,
                    level,
                    file
                };
            }

            const configReducer = function(fileName, tab) {
                return function(accumulator, entry) {
                    const xTroop = xelib.GetMasterRecord(xelib.GetLinksTo(entry, 'LVLO\\Reference'));
                    const troopFileName = xelib.GetFileName(xelib.GetElementFile(xTroop));
                    if (fileName !== cwoFileName && troopFileName === 'Skyrim.esm') {
                        return accumulator;
                    }
                    const name = troopFileName + '::' + xelib.GetHexFormID(xTroop, true, true);
                    const oldCount = accumulator[name] ? accumulator[name].oldCount + (fileName !== cwoFileName ? 0 : 1) : fileName !== cwoFileName ? 0 : 1;
                    const count = patcherSettings.troopConfig[tab] && 
                        patcherSettings.troopConfig[tab][name] ? patcherSettings.troopConfig[tab][name].count : oldCount;
                    const oldLevel =  accumulator[name] ? accumulator[name].oldLevel : parseInt(xelib.GetValue(entry, 'LVLO\\Level'));
                    const level = patcherSettings.troopConfig[tab] && 
                        patcherSettings.troopConfig[tab][name] ? patcherSettings.troopConfig[tab][name].level : oldLevel;
                    const reference = xelib.LongName(xTroop);
                    if (patcherSettings.troopConfig[tab][name] && patcherSettings.troopConfig[tab][name].reference !== reference) {
                        patcherSettings.troopConfig[tab][name].reference = reference;
                    }
                    const troop = {
                        reference,
                        display: xelib.FullName(xTroop) ?  xelib.FullName(xTroop) : xelib.EditorID(xTroop),
                        name,
                        count,
                        oldCount,
                        level,
                        oldLevel,
                        formID: xelib.GetHexFormID(xTroop),
                        race: xelib.FullName(xelib.GetLinksTo(xTroop, 'RNAM'))
                    };

                    accumulator[name] = troop;
                    return accumulator;
                }
            }

            $scope.troopConfig[0] = {
                fileName: cwoFileName,
                troops: [{}, {}]
            };
            $scope.troopConfig[0].troops[0] = xelib.GetElements(cwoLCharSoldierImperial, 'Leveled List Entries').reduce(configReducer(cwoFileName, 0), {});
            $scope.troopConfig[0].troops[1] = xelib.GetElements(cwoLCharSoldierSons, 'Leveled List Entries').reduce(configReducer(cwoFileName, 1), {});
            
            const iOverrides = xelib.GetOverrides(LCharSoldierImperial);
            const sOverrides = xelib.GetOverrides(LCharSoldierSons);

            let otherModdedTroops = {};
            iOverrides.forEach(function(override) {
                const fileName = xelib.GetFileName(xelib.GetElementFile(override));
                if (['Skyrim.esm', 'Civil War Overhaul.esp', 'zPatch.esp'].indexOf(fileName) === -1) {
                    otherModdedTroops[fileName] = Object.assign({
                        iRecord: override
                    }, otherModdedTroops[fileName])
                }
            })

            sOverrides.forEach(function(override) {
                const fileName = xelib.GetFileName(xelib.GetElementFile(override));
                if (['Skyrim.esm', 'Civil War Overhaul.esp', 'zPatch.esp'].indexOf(fileName) === -1) {
                    otherModdedTroops[fileName] = Object.assign({
                        sRecord: override
                    }, otherModdedTroops[fileName])
                }
            })

            let i = 1;
            Object.keys(otherModdedTroops).forEach(function(key) {
                const config = otherModdedTroops[key];
                const troopImperials = config.iRecord ? xelib.GetElements(config.iRecord, 'Leveled List Entries').reduce(configReducer(key, 0), {}) : {};
                const troopSons = config.sRecord ? xelib.GetElements(config.sRecord, 'Leveled List Entries').reduce(configReducer(key, 1), {}) : {};
                if (Object.keys(troopImperials).length === 0 && Object.keys(troopSons).length === 0) {
                    return;
                }
                $scope.troopConfig[i] = {
                    fileName: key,
                    troops: [troopImperials, troopSons]
                };
                i++;        
            });

        },
        defaultSettings: {
            troopConfig: [{}, {}]
        }
    },
    requiredFiles: ['Civil War Overhaul.esp'],
    getFilesToPatch: (files) => {
        return files.subtract(['zePatch.esp']);
    },
    execute: (patchFile, helpers, settings, locals) => ({
        process: [{
            load: {
                signature: 'LVLN',
                filter: function(record) {
                    return ['LCharSoldierImperial', 'LCharSoldierSons'].indexOf(xelib.EditorID(record)) > -1;
                }
            },
            patch: function(record) {
                xelib.RemoveElement(record, 'Leveled List Entries');
                let cwoElements = {};
                let totalElements = {};
                xelib.GetOverrides(record).forEach(override => {
                    const fileName = xelib.GetFileName(xelib.GetElementFile(override));
                    if (fileName === xelib.GetFileName(xelib.GetElementFile(record))) {
                        return;
                    }
                    let totalsPerOverride = {};
                    xelib.GetElements(override, 'Leveled List Entries').forEach(form => {
                        const link = xelib.GetLinksTo(form, 'LVLO\\Reference');
                        if (link === 0) {
                            return;
                        }
                        const reference = xelib.GetMasterRecord(link);
                        const troopKey = xelib.GetFileName(xelib.GetElementFile(reference)) + '::' + xelib.GetHexFormID(reference, true, true);
                        cwoElements[troopKey] = {
                                ref: xelib.GetValue(form, 'LVLO\\Reference'),
                                lev: xelib.GetValue(form, 'LVLO\\Level'),
                                cnt: xelib.GetValue(form, 'LVLO\\Count')
                            };
                        if (!totalsPerOverride[troopKey]) {
                            totalsPerOverride[troopKey] = 1;
                        } else {
                            totalsPerOverride[troopKey]++;
                        }
                    });
                    Object.keys(totalsPerOverride).forEach(x => {
                        if (!totalElements[x]) {
                            totalElements[x] = totalsPerOverride[x];
                        } else if (totalsPerOverride[x] > totalElements[x]) {
                            totalElements[x] = totalsPerOverride[x];
                        }
                    });
                });
                Object.keys(cwoElements).forEach(x => {
                    for (let i = 0;i<totalElements[x];i++) {
                        xelib.AddLeveledEntry(record, cwoElements[x].ref, cwoElements[x].lev, cwoElements[x].cnt)
                    }
                });
            }
        }, {
            load: {
                signature: 'LVLN',
                filter: function(record) {
                    return ['CWOLCharSoldierImperial', 'CWOLCharSoldierSons', 'CWOLCharFortSoldierImperial', 'CWOLCharFortSoldierSons'].indexOf(xelib.EditorID(record)) > -1;
                }
            },
            patch: function(record) {
                const fileNames = xelib.GetLoadedFileNames(false);
                let cwoRefs = xelib.GetElements(record, 'Leveled List Entries').reduce((accumulator, current) => {
                    const reference = xelib.GetValue(current, 'LVLO\\Reference');
                    const level = xelib.GetValue(current, 'LVLO\\Level');
                    const xTroop = xelib.GetLinksTo(current, 'LVLO\\Reference');
                    const troopKey = xelib.GetFileName(xelib.GetElementFile(xTroop)) + '::' + xelib.GetHexFormID(xTroop, true, true);
                    const count = accumulator[troopKey] ? accumulator[troopKey].count + 1 : 1;
                    accumulator[troopKey] = {
                        count,
                        reference,
                        level,
                        file: 'Civil War Overhaul.esp'
                    }
                    return accumulator;
                }, {});
                xelib.RemoveElement(record, 'Leveled List Entries');
                const isStormCloaks = xelib.EditorID(record) === 'CWOLCharSoldierSons' || xelib.EditorID(record) === 'CWOLCharFortSoldierSons' ? 1 : 0;
                Object.assign(cwoRefs, settings.troopConfig[isStormCloaks], {});
                const nonStandardTroops = xelib.GetElements(xelib.GetElement(xelib.FileByName('Civil War Overhaul.esp'), 'CWONonStandardSoldiers'), 'FormIDs').map(formID => {
                    return xelib.LongName(xelib.GetLinksTo(formID));
                })
                Object.keys(cwoRefs).forEach(key => {
                    if (fileNames.indexOf(cwoRefs[key].file) === -1 || 
                        (xelib.EditorID(record).indexOf('Fort') > -1 && 
                        nonStandardTroops.indexOf(cwoRefs[key].reference) > -1)) {
                        return;
                    }
                    for (let i = 0;i<cwoRefs[key].count;i++) {
                            xelib.AddLeveledEntry(record, cwoRefs[key].reference, cwoRefs[key].level + '', '1');                    
                    }
                })
            }
        }]
    })
});
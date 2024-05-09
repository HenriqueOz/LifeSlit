audio_set_master_gain(0, global.masterVolume/10);
audio_group_set_gain(GroupSFX, global.sfxVolume/10, 0);
audio_group_set_gain(GroupMusic, global.bgmVolume/10, 0);
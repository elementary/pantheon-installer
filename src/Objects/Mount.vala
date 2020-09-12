// -*- Mode: vala; indent-tabs-mode: nil; tab-width: 4 -*-
/*-
 * Copyright (c) 2018 elementary LLC. (https://elementary.io)
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * Authored by: Michael Aaron Murphy <michael@system76.com>
 */

public class Installer.Mount {
    public string partition_path;
    public string parent_disk;
    public string mount_point;
    public uint64 sectors;
    public uint64 sector_size;
    public Distinst.FileSystem filesystem;
    public Flags flags;
    public PartitionMenu menu;

    [Flags]
    public enum Flags {
        FORMAT = 1,
        LVM = 2,
        LVM_ON_LUKS = 4
    }

    public Mount (string partition, string parent_disk, string mount,
                  uint64 sectors, uint64 sector_size, Flags flags, Distinst.FileSystem fs,
                  PartitionMenu menu) {
        filesystem = fs;
        mount_point = mount;
        partition_path = partition;
        this.flags = flags;
        this.menu = menu;
        this.parent_disk = parent_disk;
        this.sectors = sectors;
        this.sector_size = sector_size;
    }

    public bool is_valid_boot_mount () {
        return filesystem == Distinst.FileSystem.FAT16
            || filesystem == Distinst.FileSystem.FAT32;
    }

    public bool is_valid_root_mount () {
        return filesystem != Distinst.FileSystem.FAT16
            && filesystem != Distinst.FileSystem.FAT32
            && filesystem != Distinst.FileSystem.NTFS;
    }

    public bool is_lvm () {
        return Flags.LVM in flags;
    }

    public bool should_format () {
        return Flags.FORMAT in flags;
    }
}

public class Installer.LuksCredentials {
    public string device;
    public string pv;
    public string password;

    public LuksCredentials (string device, string pv, string password) {
        this.device = device;
        this.pv = pv;
        this.password = password;
    }
}

/* radare - LGPL - Copyright 2009 pancake<nopcode.org> */

[CCode (cheader_filename="r_io.h", cprefix="r_io", lower_case_cprefix="r_io_")]
namespace Radare
{
	[Compact]
	[CCode (cname="struct r_io_t", free_function="r_io_free", cprefix="r_io_")]
	public class Io {
		public enum Flags {
			READ = 0,
			WRITE = 1,
			RDWR = 2,
		}

		public enum Seek {
			SET = 0,
			CUR = 1,
			END = 2,
		}
		/**
		 * Do the io! :D
	 	 */
		public Io();
		public Io* free();
		public bool init();
		public bool set_write_mask(int fd, uint8 *buf, int len);
		public int open(string uri, int flags, int mode);
		public int read(int fd, out uint8 *buf, int len);
		public int write(int fd, uint8 *buf, int len);
		public uint64 lseek(int fd, uint64 addr, int whence);
		public int system(int fd, string cmd);
		public int close(int fd);
		public uint64 size(int fd);

		/* handle */
		public struct Handle {
			string name;
			string desc;
			// TODO: lot of missing stuff here :)
		}
		public bool handle_open(int fd, Io.Handle plugin);
		public bool handle_add(Io.Handle plugin);
		public int handle_generate();
		public void handle_list();

		/* maps */
		public struct Map {
			int fd;
			uint64 from;
			uint64 to;
		}
		public Io.Map map_resolve(int fd);
		public bool map_add(int fd, uint64 addr, uint64 size);
		public bool map_del(int fd);
		public void map_list(); // DEPRECATE
		public int map_read_at(uint64 addr, uint8 *buf, uint64 len);
		public int map_write_at(uint64 addr, uint8 *buf, uint64 len);
		/* sections */
		[CCode (cname="struct r_io_section_t")]
		public struct Section {
			string comment;
			uint64 from;
			uint64 to;
			uint64 vaddr;
			uint64 paddr;
			int rwx; // TODO: use perms
		}
		/* desc */
		[CCode (cname="struct r_io_desc_t")]
		public struct Desc {
			int fd;
			int flags;
			const string name;
		}
		public bool desc_add(int fd, string file, Io.Flags flags);
	}
}

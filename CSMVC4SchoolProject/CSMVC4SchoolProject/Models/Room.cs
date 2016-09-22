
namespace CSMVC4SchoolProject.Models
{
    public class Room
    {
        public short  KeyField    { get; set; }
        public string description { get; set; }
        public int?   MaxStudents { get; set; }
        public bool  DeleteYN     { get; set; }
        public bool  UpdateYN     { get; set; }
        public bool  OKToDelete   { get; set; }
    }
}
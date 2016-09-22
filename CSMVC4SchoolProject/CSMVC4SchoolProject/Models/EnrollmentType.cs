namespace CSMVC4SchoolProject.Models
{
    public class EnrollmentType
    {
        public short KeyField { get; set; }
        public string Description { get; set; }
        public short? DisplayOrder { get; set; }
        public bool OKToDelete { get; set; }
        public bool UpdateYN { get; set; }
        public bool DeleteYN { get; set; }
    }
}
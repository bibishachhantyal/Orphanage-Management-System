package orphanage.model;

public class TimeSlotStats {
    private int morning;
    private int afternoon;
    private int evening;

    public TimeSlotStats() {}

    public TimeSlotStats(int morning, int afternoon, int evening) {
        this.morning = morning;
        this.afternoon = afternoon;
        this.evening = evening;
    }

    public int getMorning() { return morning; }
    public void setMorning(int morning) { this.morning = morning; }

    public int getAfternoon() { return afternoon; }
    public void setAfternoon(int afternoon) { this.afternoon = afternoon; }

    public int getEvening() { return evening; }
    public void setEvening(int evening) { this.evening = evening; }

    public int getTotal() { return morning + afternoon + evening; }
}

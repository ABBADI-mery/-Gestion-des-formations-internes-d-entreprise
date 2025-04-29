package mapper;

public class SessionParticipationCount {
    private String sessionName;
    private long participantCount;

    public SessionParticipationCount(String sessionName, long participantCount) {
        this.sessionName = sessionName;
        this.participantCount = participantCount;
    }

    // Getters requis par Gson
    public String getSessionName() {
        return sessionName;
    }

    public long getParticipantCount() {
        return participantCount;
    }
}
/*
TO-DO-LIST :
    3.comment haye faz 1 ghabel piade sazi hastand
    4.bad as hame comment haye man sonar qube ha tamoom shan ;)
    5.joda kardan property o folan dar hame class ha
    6.string ha va err code ha hame variable beshan
    7.chand khat javadoc ha <p> haye joda bezanim
    8.sonarqube sonarqube sonarqubeeeeee
 */

import com.lattestudio.musicplayer.db.DataBase;
import com.lattestudio.musicplayer.fx.RunFx;
import com.lattestudio.musicplayer.network.Server;
import com.lattestudio.musicplayer.util.Colors;
import com.lattestudio.musicplayer.util.Message;



class Main{
    public static void main(String[] args) throws Exception {
        Message.restoreUsers();
        Message.cyanServerMessage("USERNAMES RESTORED : "+ DataBase.getUsernames());
        Message.cyanServerMessage("EMAILS RESTORED :" + DataBase.getEmails());
        Message.cyanServerMessage("SONG NAMES RESTORED : " + DataBase.loadSongsNames());
        Message.cyanAdminMessageToAdminPanel("SONGS : " + DataBase.getMusics());
        Thread serverRunner = new Thread(new ServerRunner());
        serverRunner.setName("SERVER");
        serverRunner.setPriority(Thread.MAX_PRIORITY);
        serverRunner.start();
        Thread.sleep(50);
        Message.cyanAdminMessageToAdminPanel("ADMINISTRATOR PANEL IS STARTING:...");
        System.out.println(Colors.BLUE_BACKGROUND_BRIGHT);
        RunFx.main(args);
        System.out.println(Colors.RESET);
    }
}

class ServerRunner implements Runnable {
    @Override
    public void run() {
        try {
            Server server = new Server();
            server.start();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
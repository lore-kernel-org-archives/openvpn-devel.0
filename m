From: Aaron Sethman <androsyn@...45...>
In-Reply-To: <200302080347.h183lrf20924@...41...>
Message-ID: <Pine.LNX.4.50.0302091959100.10985-100000@...48...>
References: <200302080347.h183lrf20924@...41...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Opened file descriptors in script calls
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Sun Feb  9 17:04:03 2003
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: James Yonan <jim@...41...>
Cc: Alberto Gonzalez Iniesta <agi@...64...>, openvpn-devel@lists.sourceforge.net

Here is a simple little replacement for system() that does close file
descriptors.  The main issue with it is though, it ends up picking an
arbitrary number of fds to close.  I picked closing 0 to 99.

Aaron


int s_system(const char *string)
{
	pid_t pid;
	int x;
 	pid = fork()

 	if(pid == -1)
 	{
         	return -1;
 	}

 	if(pid > 0)
 	{
 	 	int status;
         	wait(&status);
         	return(status);
        }

        for(x = 0; x < 100; x++)
 	{
 		close(x);
 	}
        execlp("/bin/sh", "-c", string);

}



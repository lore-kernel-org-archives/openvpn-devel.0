From: Alberto Gonzalez Iniesta <agi@...5...>
Subject: Re: [Openvpn-devel] Opened file descriptors in script calls
Message-ID: <20030210103449.GH4850@...30...>
References: <200302080347.h183lrf20924@...41...> <Pine.LNX.4.50.0302091959100.10985-100000@...48...>
Mime-Version: 1.0
In-Reply-To: <Pine.LNX.4.50.0302091959100.10985-100000@...48...>
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
Date: Mon Feb 10 02:36:03 2003
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Sun, Feb 09, 2003 at 08:01:12PM -0500, Aaron Sethman wrote:
> 
> Here is a simple little replacement for system() that does close file
> descriptors.  The main issue with it is though, it ends up picking an
> arbitrary number of fds to close.  I picked closing 0 to 99.
> 
> Aaron
> 
> 
> int s_system(const char *string)
> {
> 	pid_t pid;
> 	int x;
>  	pid = fork()
> 
>  	if(pid == -1)
>  	{
>          	return -1;
>  	}
> 
>  	if(pid > 0)
>  	{
>  	 	int status;
>          	wait(&status);
>          	return(status);
>         }
> 
>         for(x = 0; x < 100; x++)
>  	{
>  		close(x);
>  	}
>         execlp("/bin/sh", "-c", string);
> 
> }
> 

Hi,

Again, I'm no C hacker, but I think this should be better:

for(x = 3; x < 100; x++)

Since the first 3 fds (stdin, stdout and stderr) should be kept open.

Regards,

Alberto


-- 
Alberto Gonzalez Iniesta       | They that give up essential liberty
agi@(agi.as|debian.org)        | to obtain a little temporary safety
Encrypted mail preferred       | deserve neither liberty nor safety.

Key fingerprint = 9782 04E7 2B75 405C F5E9  0C81 C514 AF8E 4BA4 01C3


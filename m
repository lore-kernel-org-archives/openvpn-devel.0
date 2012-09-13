Message-ID: <5051DECA.1010801@...1147...>
Date: Thu, 13 Sep 2012 15:25:30 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <CAGsOL8+F=7AtU_7wa5KpA-8q87Jm+GN5ncPqn3K7FVfXryV7SQ@...278...>
In-Reply-To: <CAGsOL8+F=7AtU_7wa5KpA-8q87Jm+GN5ncPqn3K7FVfXryV7SQ@...278...>
Subject: Re: [Openvpn-devel] openvpn-gui disconnect
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Nelson Teixeira <nelson777@...277...>
Cc: openvpn-devel@lists.sourceforge.net, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>

Hi Nelson,

Nelson Teixeira wrote:
> Hello,
>
> Sorry by writting directly to devel list, but I'm not being able to 
> solve this problem I'm in and thought maybe you would be so kind to 
> take a look. Thanks in advance :)
>
> I'm having trouble in finding how to end openvpn programmatically in 
> windows. If I run openvpn in command line, I can end it graciously 
> with F4. What I want to do is to make my python program (or batch 
> file/executable program, can be in C/C++) do the same thing: end it 
> gracioulsy, allow for openvpn to do it's cleanup tasks.
> Yet the only thing available to stop the process is taskkill /F /PID 
> <PID_NUMBER> that ends it immediately without allowing openvpn to do 
> it's  cleanup tasks. If I don't use /F switch, it just ignores the 
> command. I tried  also with /T (Tree Kill). No luck.
> I also tried to get openvpn pid and send it a signal using this python 
> code (it's python but it's easily understandable by anyone:
>
the "proper" way to do this is to use the management interface; the 
openvpn-gui code does just that (file openvpn.c):

725     /* Construct command line */
726     _sntprintf_0(cmdline, _T("openvpn "
727         "--config \"%s\" %s --service %s 0 --log%s \"%s\" "
728         "--management 127.0.0.10 %hd stdin --auth-retry interact "
729         "--management-hold --management-query-passwords --tls-exit"),


you can then use the same management interface to properly shut down 
openvpn again.

HTH,

JJK



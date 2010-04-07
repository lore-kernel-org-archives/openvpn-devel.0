In-Reply-To: <4BBC71F6.7040802@...1147...>
References: <OF16C98C16.EEA12E96-ONC12576FD.006F673E-C12576FD.00713519@...1343...>	<201004070959.09215.hhund@...194...>
	<4BBC71F6.7040802@...1147...>
Message-ID: <OF210DEF84.D777584C-ONC12576FE.004252FE-C12576FE.00437FD4@...1343...>
From: Johan Ymerson <johan.ymerson@...1342...>
Date: Wed, 7 Apr 2010 14:17:16 +0200
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] DNS problems with openvpn 2.1 on Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel@lists.sourceforge.net



Jan Just Keijser <janjust@...1147...> wrote on 2010-04-07 13:52:22:
> isn't
>   ipconfig /flushdns
No, doesn't help in this case.

> or
>   net stop dnscache
>   net start dnscache
I hadn't tested this before, but yes, it does seem to help (only done limited testing so far).

> enough? This might be related to
>  http://support.microsoft.com/kb/311218
Related maybe, but at least that work around does not work in my case.

>
> I've recommended to people on the -users list to use an 'up' script with
>   net stop dnscache
>   net start dnscache
> this has worked in 99% of the cases.
For me, it doesn't work in the 'up' script, I must put it in the 'route-up' script. Maybe that is the last 1% :-)

/Johan




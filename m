From: <p.j.bakker@...1543...>
Sender: "Paul Bakker" <p.j.bakker@...1548...>
References: <kr8jgd$3v7$1@...1062...>
	<03e201ce7bc8$f4c63870$de52a950$@polarssl.org>
	<51DAAB0F.3030006@...1833...> <51DAB3E5.2030602@...1833...>
In-Reply-To: <51DAB3E5.2030602@...1833...>
Date: Tue, 9 Jul 2013 11:09:19 +0200
Message-ID: <005001ce7c84$020348a0$0609d9e0$@polarssl.org>
MIME-Version: 1.0
Content-Language: nl
Subject: Re: [Openvpn-devel] OpenVPN Connect on Android fails to connect
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Peter Meiser' <meiser@...1833...>
Cc: openvpn-devel@lists.sourceforge.net

Yeah!

-82 is: POLARSSL_ERR_NET_WANT_READ

It means that somewhere in the code, OpenVPN calls a read() or a write() and
seems to not handle the return value properly.

Paul
> -----Original Message-----
> From: Peter Meiser [mailto:meiser@...1833...]
> Sent: maandag 8 juli 2013 14:43
> To: p.j.bakker@...1543...
> Subject: Re: [Openvpn-devel] OpenVPN Connect on Android fails to connect
> 
> Hi Paul,
> 
> I changed include/polarssl/config.h and defined POLARSSL_DEBUG_C. I see
> the following output in the OpenVPN debug output (configuring "verb 11" in
> the config).
> 
> Mon Jul  8 14:09:57 2013 us=442655 ::ffff:127.0.0.1 PolarSSL alert:
> ssl_srv.c(0421): ssl_fetch_input() returned -82 (0xffffffae) Mon Jul  8
14:09:57
> 2013 us=442796 ::ffff:127.0.0.1 PolarSSL alert: ssl_tls.c(3708):
ssl_handshake()
> returned -82 (0xffffffae)
> 
> Does that help?
> 
> Best regards,
> Peter
> 
> Am 08.07.2013 14:05, schrieb Peter Meiser:
> > Hi Paul,
> >
> > could you give me some hints to enable debug output in PolarSSL?
> >
> > Thanks in advance,
> > Peter
> >
> > Am 08.07.2013 12:50, schrieb p.j.bakker@...1543...:
> >> Hi Peter,
> >>
> >> Are you able to enable the PolarSSL debug and send us some debug
> >> information?
> >> That would help with determining possible angles.
> >>
> >> Paul
> >>
> >>> -----Original Message-----
> >>> From: Peter Meiser [mailto:meiser@...1833...]
> >>> Sent: zaterdag 6 juli 2013 10:12
> >>> To: openvpn-devel@lists.sourceforge.net
> >>> Subject: [Openvpn-devel] OpenVPN Connect on Android fails to connect
> >>>
> >>> Hi,
> >>>
> >>> I run OpenVPN 2.3.2 with PolarSSL 1.2.8 on a MIPS embedded linux.
> >>>
> >>> When trying to connect with OpenVPN Connect on Android (version
> >>> 1.1.11), I see the following error message in the log:
> >>>
> >>>
> >>> 21:35:11.463 -- Client exception in transport_recv_excode: PolarSSL:
> >>> SSL
> >> read
> >>> error : SSL - Verification of the message MAC failed
> >>>
> >>>
> >>> When OpenVPN is linked against OpenSSL, the smartphone connects
> >>> successfully.
> >>>
> >>> Could you help me finding out the issue?
> >>>
> >>> Thanks in advance,
> >>> Peter
> >>>
> >>>
> >>>
> >> ---------------------------------------------------------------------
> >> -------
> >> --
> >>> This SF.net email is sponsored by Windows:
> >>>
> >>> Build for Windows Store.
> >>>
> >>> http://p.sf.net/sfu/windows-dev2dev
> >>> _______________________________________________
> >>> Openvpn-devel mailing list
> >>> Openvpn-devel@lists.sourceforge.net
> >>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> >>
> >>



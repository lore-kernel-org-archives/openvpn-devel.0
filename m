Message-ID: <53A9AB67.6070603@...1516...>
Date: Tue, 24 Jun 2014 18:46:31 +0200
From: Holger Kummert <Holger.Kummert@...1516...>
MIME-Version: 1.0
References: <1397645317-20116-1-git-send-email-Holger.Kummert@...1516...>	
	<20140418210522.GE16637@...1296...>
	<53525655.4010301@...1147...>	 <538CA61B.9060803@...1516...>
	<1403533437.15555.49.camel@...1865...>
In-Reply-To: <1403533437.15555.49.camel@...1865...>
Subject: Re: [Openvpn-devel] Wanted: NTLM-Testers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: David Woodhouse <dwmw2@...1866...>
Cc: openvpn-devel@lists.sourceforge.net


Hello David,

thanks for taking time and reviewing and testing the code.

Am 23.06.2014 16:23, schrieb David Woodhouse:
> Looking over the patches first... they make the client work in OEM or
> Unicode mode according to what the server asks for... but then only ever
> admit to supporting Unicode mode in the 'phase 1' packet anyway. So a
> sane server is *never* going to ask you to do OEM, and you might as well
> ditch all the conditional code for supporting that. (Quite frankly, even
> if you add the OEM flag to your phase 1 packet, a sane server in 2014 is
> *still* never going to ask you to do OEM mode anyway, is it?)

Are you sure that a server will never ask to use the OEM charset?
If yes, the  OEM code could of course be elimintated.
Or is this more a kind of assumption?

>
> Also, it is strictly correct to assume that the input strings are utf-8?
> It certainly *ought* to be =E2=80=94 again, it's 2014 so who in their rig=
ht mind
> would be using non-UTF8 locales? But some nutters insist on remaining
> stuck in the 20th century...

Yes, probably ...
But as I've written to Gert 3 weeks ago, this group has decided
to presume UTF-8-encoding _internally_. If an environment doesn't=20
support it, or is misconfigured, the "outer interfaces" of Openvpn
should take care of this (Manager, config file, etc.).

>
> You also don't seem to include the NTLM_NEGOTIATE_TARGET_INFO flag in
> your phase 1 packet, which means I'd be surprised if you ever actually
> get the target info back from a server in its challenge... which in turn
> means I'd be surprised if you'd actually exercised that part of the
> NTLMv2 code path. Or do some servers send it 'unsolicited'? Samba
> apparently doesn't send it even if I do set the TARGET_INFO flag in the
> phase_1 packet...

Well the Windows 2008 server I'm testing against actually sends
Target-Info. It seems that this server ignores what options are set in the
initial phase-1-packet and has a somehow preconfigured phase-2-answer.
That stiffness makes me a bit cautious in trusting the negotiation=20
parameters
like UTF (s.above).

>
> Yours is actually the first implementation of NTLMv2 auth that I've seen
> =E2=80=94 other implementations seem to have a combination of NTLMv1 and =
'NTLMv2
> session' authentication =E2=80=94 see
> http://curl.cofman.dk/rfc/ntlm.html#theNtlm2SessionResponse and
> http://git.infradead.org/users/dwmw2/openconnect.git/commitdiff/fe5cf5fd6=
7 for example. We send just the single phase1 packet, and the server either=
 takes us up on the offer of NTLMv2 session auth, or not.
>
> All that said, these patches do seem to work for NTLMv1 and NTLMv2
> authentication to my test server. Although I need to explicitly *ask*
> for NTLMv2; if I just say 'ntlm' then it uses NTLMv1. That isn't what I
> expected after reading the commit message on the second patch.

This is just backward compatibility: 'ntlm' refers to NTLMv1, and the
new 'ntlm2' to NTLMv2.

>
> And if I say '--http-proxy localhost 3128 auto', it doesn't work at all.
> And doesn't really tell me why, which is naughty of it:
>
> Enter HTTP Proxy Username:dwoodhou
> Enter HTTP Proxy Password:
> Mon Jun 23 14:36:03 2014 SIGTERM[soft,init_instance] received, process ex=
iting

This looks a bit weird. Are you sure you applied both patches?
Maybe the logging level should be raised.
At least some parts of the http handshake should be seen.

>
>
> However, one of the things that NTLM is supposed to offer me is
> single-sign-on. If I've logged in to my workstation using my domain
> password (and I have), then single-sign-on ought to work by using
> Samba's /usr/bin/ntlm_auth helper tool. That works for other things like
> Firefox and the Evolution mail client... and for proxy auth with
> OpenConnect too, of course. There's a simple implementation at
> http://git.infradead.org/users/dwmw2/openconnect.git/commitdiff/583ee4b6c=
3 which you are welcome to copy into OpenVPN under GPLv2.

Or what about if you try to include this feature in OpenVpn?
You know for sure much more about that code than me ...

>
> Of course, GSSAPI support would also give me single-sign-on. But you
> don't support that either. Again, you're welcome to use my code from
> OpenConnect if it's useful. RFC1928 says that SOCKS implementations MUST
> support GSSAPI auth too, FWIW :)
>


Best regards,
Holger


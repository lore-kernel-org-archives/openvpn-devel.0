Content-Type: multipart/alternative;
	boundary="Apple-Mail=_BEFBEB69-6D9A-4041-A5AB-805712492B48"
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Jens Neuhalfen <openvpn-devel@...2127...>
In-Reply-To: <CAKuzo_geGTkH_d42-xnx7NJUXBRFyahajJAdW8+eZ0eYn2HRpg@...278...>
Date: Sat, 4 Jun 2016 09:28:42 +0200
Message-Id: <0EB7FB8D-1A08-4320-A587-435B0B280071@...2127...>
References: <1464883738-904-1-git-send-email-openvpn@...2080...>
	<1464976163-6162-1-git-send-email-openvpn@...2080...>
	<20160603181404.GM53051@...1296...>
	<CAKuzo_hyz1g_VqiU_AR-Q69FiXA_9K+MmPYsE=J3M41iKjyDeA@...278...>
	<CAKuzo_geGTkH_d42-xnx7NJUXBRFyahajJAdW8+eZ0eYn2HRpg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Another fix related to unit test
	framework
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--Apple-Mail=_BEFBEB69-6D9A-4041-A5AB-805712492B48
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

=E2=80=A6

> IMO, the unit testing patches shouldn't have been merged into the release=
 branch

I agree. This patch was in retrospective clearly not ready for a release br=
anch. A lot of people spend time to hot fix a broken build.

My root cause analysis boils down to:

   Developers cannot detect multi-platform (build/run) issues with an appro=
priate effort (or at all).

We already have discussed solutions to this:

1) Enable developers to run the =E2=80=9Cauthoritative=E2=80=9D buildslave =
tests before submitting patches
2) Provide developers tooling to quickly (preferred: locally) run iteration=
s while developing

#1 will need some processes & tooling by the current  maintainers.
#2 will be taken care of with the Vagrant based integration tests.

Opinions?

Jens


--Apple-Mail=_BEFBEB69-6D9A-4041-A5AB-805712492B48
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html charset=
=3Dutf-8"></head><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: s=
pace; -webkit-line-break: after-white-space;" class=3D""><div class=3D"">=
=E2=80=A6</div><div class=3D""><br class=3D""></div><div><blockquote type=
=3D"cite" class=3D""><div class=3D""><div dir=3D"ltr" style=3D"font-family:=
 Helvetica; font-size: 12px; font-style: normal; font-variant-caps: normal;=
 font-weight: normal; letter-spacing: normal; orphans: auto; text-align: st=
art; text-indent: 0px; text-transform: none; white-space: normal; widows: a=
uto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><div cl=
ass=3D"gmail_extra"><div class=3D"gmail_quote"><div class=3D"">IMO, the uni=
t testing patches shouldn't have been merged into the release branch<br cla=
ss=3D""></div></div></div></div></div></blockquote><div><br class=3D""></di=
v></div><div class=3D"">I agree. This patch was in retrospective clearly no=
t ready for a release branch. A lot of people spend time to hot fix a broke=
n build.</div><div class=3D""><br class=3D""></div><div class=3D"">My root =
cause analysis boils down to:</div><div class=3D""><br class=3D""></div><di=
v class=3D"">&nbsp; &nbsp;Developers cannot detect multi-platform (build/ru=
n) issues with an appropriate effort (or at all).</div><div class=3D""><br =
class=3D""></div><div class=3D"">We already have discussed solutions to thi=
s:</div><div class=3D""><br class=3D""></div><div class=3D"">1) Enable deve=
lopers to run the =E2=80=9Cauthoritative=E2=80=9D buildslave tests before s=
ubmitting patches</div><div class=3D"">2) Provide developers tooling to qui=
ckly (preferred: locally) run iterations while developing</div><div class=
=3D""><br class=3D""></div><div class=3D"">#1 will need some processes &amp=
; tooling by the current &nbsp;maintainers.</div><div class=3D"">#2 will be=
 taken care of with the Vagrant based integration tests.</div><div class=3D=
""><br class=3D""></div><div class=3D"">Opinions?</div><div class=3D""><br =
class=3D""></div><div class=3D"">Jens</div><div class=3D""><br class=3D""><=
/div></body></html>=

--Apple-Mail=_BEFBEB69-6D9A-4041-A5AB-805712492B48--


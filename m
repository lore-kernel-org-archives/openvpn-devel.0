From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 10 Jan 2025 13:11:20 +0000
In-Reply-To: <gerrit.1733989644000.I576e74f3276362606e9cbd50bb5adbebaaf209cc@...2715...>
References: <gerrit.1733989644000.I576e74f3276362606e9cbd50bb5adbebaaf209cc@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <9c8cfb6d42ff083d85887acf05e367634aac4ac9-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Fzn7zHtUpyw="; charset=UTF-8
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: win: implement
 --dns option support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Fzn7zHtUpyw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/837?usp=3Demail )

Change subject: win: implement --dns option support
......................................................................


Patch Set 6:

(1 comment)

File src/openvpnserv/interactive.c:

http://gerrit.openvpn.net/c/openvpn/+/837/comment/29071d80_c92d5c0a :
PS5, Line 2265:         MsgToEventLog(M_SYSERR, TEXT("IsInterfaceConnected:=
 "
> How did you get to this conclusion? Works for me, and Compiler Explorer a=
lso shows that the string i [=E2=80=A6]
Yeah, it seems to work even though I'm not exactly sure what the logic is t=
hat makes it work. Maybe when you have multiple string literals the L just =
gets applied from left to right? Either way I decided to instead get TEXT()=
 removed completely from our code base, see my separate patch series. I wil=
l leave it to you whether you want to use it here and have it converted in =
my series or use L"" here directly.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/837?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I576e74f3276362606e9cbd50bb5adbebaaf209cc
Gerrit-Change-Number: 837
Gerrit-PatchSet: 6
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-Comment-Date: Fri, 10 Jan 2025 13:11:20 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Comment-In-Reply-To: d12fk <heiko@...515...>
Gerrit-MessageType: comment

--Fzn7zHtUpyw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: d12fk, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/837?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpnserv/interactive.c:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/837/comment/29071d80_c92d5c0a">Patch Set #5, Line =
2265:</a> <code style=3D"font-family:monospace,monospace">        MsgToEven=
tLog(M_SYSERR, TEXT(&quot;IsInterfaceConnected: &quot;</code></p><p><blockq=
uote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;=
">How did you get to this conclusion? Works for me, and Compiler Explorer a=
lso shows that the string i [=E2=80=A6]</blockquote></p><p style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">Yeah, it seems to work even though =
I&#39;m not exactly sure what the logic is that makes it work. Maybe when y=
ou have multiple string literals the L just gets applied from left to right=
? Either way I decided to instead get TEXT() removed completely from our co=
de base, see my separate patch series. I will leave it to you whether you w=
ant to use it here and have it converted in my series or use L&quot;&quot; =
here directly.</p></li></ul></li></ul><p>To view, visit <a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/837?usp=3Demail">change 837</a>. To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit.openvp=
n.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.o=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/837?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I576e74f3276362606e9cbd50bb5=
adbebaaf209cc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 837 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 10 Jan 2025 13:11:20=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: d12fk &lt;heiko@...515...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--Fzn7zHtUpyw=--


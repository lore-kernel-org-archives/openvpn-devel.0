From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 7 Jul 2025 16:54:05 +0000
In-Reply-To: <gerrit.1751514980000.I1aabd62e60dd18408a57baccbb0f4ebd6d2f8d67@...2715...>
References: <gerrit.1751514980000.I1aabd62e60dd18408a57baccbb0f4ebd6d2f8d67@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <84e7529be8835e3e0cb80614f875174b1cb9f624-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Z4+6thgg09Q="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: mac dns: compare
 servers before restoring backup
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

--Z4+6thgg09Q=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/1075?usp=3Demail )

Change subject: mac dns: compare servers before restoring backup
......................................................................


Patch Set 2: Code-Review-2

(1 comment)

Patchset:

PS2:
Fails t_client tests on macos buildbot worker. After some investigation the=
 problem seems to be that the IPv6 DNS server address is not shown in globa=
l DNS configuration:

```
> show Setup:/Network/Service/0347C55F-C172-49FF-BECC-C533F04B4B13/DNS
<dictionary> {
  SearchDomains : <array> {
    0 : open.vpn
  }
  SearchOrder : 5000
  ServerAddresses : <array> {
    0 : 10.194.0.1
    1 : fd00:abcd:194::1
  }
}
> show State:/Network/Global/DNS
<dictionary> {
  SearchDomains : <array> {
    0 : open.vpn
  }
  SearchOrder : 5000
  ServerAddresses : <array> {
    0 : 10.194.0.1
  }
  __CONFIGURATION_ID__ : Default: 0
  __FLAGS__ : 2
  __ORDER__ : 0
}
```



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1075?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1aabd62e60dd18408a57baccbb0f4ebd6d2f8d67
Gerrit-Change-Number: 1075
Gerrit-PatchSet: 2
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-Comment-Date: Mon, 07 Jul 2025 16:54:05 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--Z4+6thgg09Q=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: d12fk, plaisthos. </p>
<p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1075?usp=3Demail">V=
iew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1075?tab=3Dcomments">Patch Set #2:</a> </p><p style=3D"white-space: pre=
-wrap; word-wrap: break-word;">Fails t_client tests on macos buildbot worke=
r. After some investigation the problem seems to be that the IPv6 DNS serve=
r address is not shown in global DNS configuration:</p><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;">```<br>&gt; show Setup:=
/Network/Service/0347C55F-C172-49FF-BECC-C533F04B4B13/DNS<br>&lt;dictionary=
&gt; {<br>  SearchDomains : &lt;array&gt; {<br>    0 : open.vpn<br>  }<br> =
 SearchOrder : 5000<br>  ServerAddresses : &lt;array&gt; {<br>    0 : 10.19=
4.0.1<br>    1 : fd00:abcd:194::1<br>  }<br>}<br>&gt; show State:/Network/G=
lobal/DNS<br>&lt;dictionary&gt; {<br>  SearchDomains : &lt;array&gt; {<br> =
   0 : open.vpn<br>  }<br>  SearchOrder : 5000<br>  ServerAddresses : &lt;a=
rray&gt; {<br>    0 : 10.194.0.1<br>  }<br>  __CONFIGURATION_ID__ : Default=
: 0<br>  __FLAGS__ : 2<br>  __ORDER__ : 0<br>}<br>```</pre></li></ul></li><=
/ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1075=
?usp=3Demail">change 1075</a>. To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p=
><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope =
itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1075?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1aabd62e60dd18408a57baccbb0=
f4ebd6d2f8d67 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1075 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 07 Jul 2025 16:54:05=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--Z4+6thgg09Q=--


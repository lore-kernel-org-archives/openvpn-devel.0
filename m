From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 10 Oct 2025 08:03:31 +0000
In-Reply-To: <gerrit.1759923063000.I7c28da72be11c7efbed3068fbfc65f2959227bec@...2715...>
References: <gerrit.1759923063000.I7c28da72be11c7efbed3068fbfc65f2959227bec@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., marco@...2726...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <245ed7d7fb09bcb50667df1eb5e8a1d856e3c290-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="770P7bFE5M4="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: PUSH_UPDATE server:
 check IV_PROTO before sending the message to the ...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: mrbff <marco@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--770P7bFE5M4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, mrbff, plaisthos.

cron2 has posted comments on this change by mrbff. ( http://gerrit.openvpn.=
net/c/openvpn/+/1255?usp=3Demail )

Change subject: PUSH_UPDATE server: check IV_PROTO before sending the messa=
ge to the client
......................................................................


Patch Set 2: Code-Review-1

(1 comment)

Patchset:

PS2:
This does not work for me.

I have 3 clients connected, 2 with "master, sends IV" and 1 on 2.6 (freebsd=
-14-amd64 is "2.6")

```
CLIENT_LIST     freebsd-14-amd64        udp6:194.97.140.5:64748 10.204.2.46=
    fd00:abcd:204:2::100a    6448    5636    2025-10-10 09:57:55     176008=
3075     MyTokenUser      57      2       AES-256-GCM
CLIENT_LIST     cron2-freebsd-tc-amd64-25       udp6:194.97.140.21:25690   =
    10.204.2.38      fd00:abcd:204:2::1008   5383    5284    2025-10-10 09:=
58:43    1760083123       MyTokenUser     59      3       AES-256-GCM
CLIENT_LIST     cron2-macos-arm64-m2    udp6:193.149.48.144:51724       10.=
204.2.50     fd00:abcd:204:2::100b   8497    7237    2025-10-10 09:52:05   =
  1760082725      MyTokenUser     55      0       AES-256-GCM
```

Then I do a push-update-broad "-dns" (something harmless).  The log file sh=
ows

```
Oct 10 09:59:17 gentoo tun-udp-p2mp[24491]: SENT CONTROL [freebsd-14-amd64]=
: 'PUSH_UPDATE,-dns' (status=3D1)
Oct 10 09:59:17 gentoo tun-udp-p2mp[24491]: SENT CONTROL [cron2-macos-arm64=
-m2]: '' (status=3D1)
Oct 10 09:59:17 gentoo tun-udp-p2mp[24491]: Failed to process push update m=
essage sent to client ID: 0
```

why only 2 clients?  why is the message empty on the second one?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1255?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7c28da72be11c7efbed3068fbfc65f2959227bec
Gerrit-Change-Number: 1255
Gerrit-PatchSet: 2
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: mrbff <marco@...2726...>
Gerrit-Comment-Date: Fri, 10 Oct 2025 08:03:31 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--770P7bFE5M4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, mrbff, plaisthos. </p>
<p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1255?usp=3Demail">V=
iew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1255?tab=3Dcomments&amp;usp=3Demail">Patch Set #2:</a> </p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">This does n=
ot work for me.</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word=
-wrap: break-word;">I have 3 clients connected, 2 with &quot;master, sends =
IV&quot; and 1 on 2.6 (freebsd-14-amd64 is &quot;2.6&quot;)</p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">```<br>CLIE=
NT_LIST     freebsd-14-amd64        udp6:194.97.140.5:64748 10.204.2.46    =
fd00:abcd:204:2::100a    6448    5636    2025-10-10 09:57:55     1760083075=
     MyTokenUser      57      2       AES-256-GCM<br>CLIENT_LIST     cron2-=
freebsd-tc-amd64-25       udp6:194.97.140.21:25690       10.204.2.38      f=
d00:abcd:204:2::1008   5383    5284    2025-10-10 09:58:43    1760083123   =
    MyTokenUser     59      3       AES-256-GCM<br>CLIENT_LIST     cron2-ma=
cos-arm64-m2    udp6:193.149.48.144:51724       10.204.2.50     fd00:abcd:2=
04:2::100b   8497    7237    2025-10-10 09:52:05     1760082725      MyToke=
nUser     55      0       AES-256-GCM<br>```</p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Then I do a push-update-=
broad &quot;-dns&quot; (something harmless).  The log file shows</p><p clas=
s=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">```<br=
>Oct 10 09:59:17 gentoo tun-udp-p2mp[24491]: SENT CONTROL [freebsd-14-amd64=
]: &#39;PUSH_UPDATE,-dns&#39; (status=3D1)<br>Oct 10 09:59:17 gentoo tun-ud=
p-p2mp[24491]: SENT CONTROL [cron2-macos-arm64-m2]: &#39;&#39; (status=3D1)=
<br>Oct 10 09:59:17 gentoo tun-udp-p2mp[24491]: Failed to process push upda=
te message sent to client ID: 0<br>```</p><p class=3D"blocks" style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">why only 2 clients?  why is the =
message empty on the second one?</p></li></ul></li></ul><p>To view, visit <=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1255?usp=3Demail">change 12=
55</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div items=
cope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/1255?usp=3Demail"/><meta itemp=
rop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7c28da72be11c7efbed3068fbfc=
65f2959227bec </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1255 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: mrbff &lt;marco@...2726...&g=
t; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 10 Oct 2025 08:03:31=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--770P7bFE5M4=--


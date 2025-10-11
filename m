From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 11 Oct 2025 09:06:22 +0000
In-Reply-To: <gerrit.1760136547000.I08e50030b1b692d351509f541e5c0b03b5170615@...2715...>
References: <gerrit.1760136547000.I08e50030b1b692d351509f541e5c0b03b5170615@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <c6bf6ddc570ac2c943e17ebb854a1f69362a6351-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TfL9xG7/2qE="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: test_dhcp: Start a
 dhcp helper functions UT
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--TfL9xG7/2qE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

cron2 has posted comments on this change by flichtenheld. ( http://gerrit.o=
penvpn.net/c/openvpn/+/1267?usp=3Demail )

Change subject: test_dhcp: Start a dhcp helper functions UT
......................................................................


Patch Set 1: Code-Review-2

(1 comment)

Patchset:

PS1:
```
test_dhcp.c: In function =E2=80=98test_write_dhcp_search_str=E2=80=99:
test_dhcp.c:71:83: error: \x used with no following hex digits
   71 |     const char output_1[27] =3D "\x77\x1a\x07openvpn\x03net\x00\x07=
openvpn\x{03}com";
      |                                                                    =
               ^
test_dhcp.c:71:31: error: initializer-string for array of =E2=80=98char=E2=
=80=99 is too long [-Werror]
   71 |     const char output_1[27] =3D "\x77\x1a\x07openvpn\x03net\x00\x07=
openvpn\x{03}com";
      |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~
test_dhcp.c:116:64: error: \x used with no following hex digits
  116 |     const char output_5[15] =3D "\x77\x0d\x03sub\x00\x{06}domain";
      |                                                                ^
test_dhcp.c:116:31: error: initializer-string for array of =E2=80=98char=E2=
=80=99 is too long [-Werror]
  116 |     const char output_5[15] =3D "\x77\x0d\x03sub\x00\x{06}domain";
      |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[2]: *** [Makefile:3164: dhcp_testdriver-test_dhcp.o] Error 1
```



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1267?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I08e50030b1b692d351509f541e5c0b03b5170615
Gerrit-Change-Number: 1267
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Sat, 11 Oct 2025 09:06:22 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--TfL9xG7/2qE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1267?usp=3Demail">V=
iew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1267?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">```<br>test_dhcp.c: In function =E2=80=98test_write_dhcp_search_str=E2=
=80=99:<br>test_dhcp.c:71:83: error: \x used with no following hex digits<b=
r>   71 |     const char output_1[27] =3D &quot;\x77\x1a\x07openvpn\x03net\=
x00\x07openvpn\x{03}com&quot;;<br>      |                                  =
                                                 ^<br>test_dhcp.c:71:31: er=
ror: initializer-string for array of =E2=80=98char=E2=80=99 is too long [-W=
error]<br>   71 |     const char output_1[27] =3D &quot;\x77\x1a\x07openvpn=
\x03net\x00\x07openvpn\x{03}com&quot;;<br>      |                          =
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<br>test_dhcp.c:11=
6:64: error: \x used with no following hex digits<br>  116 |     const char=
 output_5[15] =3D &quot;\x77\x0d\x03sub\x00\x{06}domain&quot;;<br>      |  =
                                                              ^<br>test_dhc=
p.c:116:31: error: initializer-string for array of =E2=80=98char=E2=80=99 i=
s too long [-Werror]<br>  116 |     const char output_5[15] =3D &quot;\x77\=
x0d\x03sub\x00\x{06}domain&quot;;<br>      |                               =
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<br>cc1: all warnings being treated as err=
ors<br>make[2]: *** [Makefile:3164: dhcp_testdriver-test_dhcp.o] Error 1<br=
>```</pre></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/1267?usp=3Demail">change 1267</a>. To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/=
settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://sc=
hema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/1267?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I08e50030b1b692d351509f541e5=
c0b03b5170615 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1267 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sat, 11 Oct 2025 09:06:22=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--TfL9xG7/2qE=--


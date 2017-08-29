MIME-Version: 1.0
From: wang yu <wangyu.cn@...277...>
Date: Tue, 29 Aug 2017 13:53:33 -0700
Message-ID: <CAEycoiUeA+zbn3vT9t3F3Df6yxsKp8HmAdiaHCMmLV1ew+d8Xw@...278...>
Content-Type: multipart/alternative; boundary="001a11c17d40c523660557ea9aaa"
Subject: [Openvpn-devel] Please take a second look at "#2 Improve
 TCP-over-TCP performance"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: gert@...1296...
Cc: openvpn-devel@lists.sourceforge.net

--001a11c17d40c523660557ea9aaa
Content-Type: text/plain; charset="UTF-8"

URL  https://community.openvpn.net/openvpn/ticket/2

As I mentioned,the custom TCP protocol(I called FakeTCP) bypasses the TCP
over TCP performance issue.Its helpful when UDP is not avaliable(being blocked
or being throttled or not well supported by NAT devices).

This was your reply:
>We are not going to implement it, though. OpenVPN over TCP is needed when
you have nasty firewalls out there that do sequence number checking and all
that - and then your FakeTCP is not going to work either. If you have no
firewalls in the way, OpenVPN over UDP works perfectly well (including
"through NAT").

Sorry,I cant get the logic behind the sentence.

UDP not avaliable is a much more common circumstance,while a nasty firewall
which tracks everything of TCP is just a rare circumstance.

This method solves most of the troubles when UDP is not avaliable just
except the nasty-firewall circumstance you mentioned.

It seems like you rejected a commonly workable feature for a rare
circumstance.

I tried to have a further discussion with you by another reply in the
Tracker,but you closed the issue without a word.

I am okay wheter or not the feature can be implemented.I just hope its
well discussed
and there is a convincing reason if it cant be implemented.If this feature
is acceptable I can make patches.

If you dont have time to discuss with me,plz leave the ticket open for a
few days,so that I can possibly get some more convincing feedback from
others.


Thanks.

--001a11c17d40c523660557ea9aaa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div style=3D"font-size:12.8px">URL =C2=A0<a href=3D"https=
://community.openvpn.net/openvpn/ticket/2" target=3D"_blank">https://commun=
ity.openvpn.<wbr>net/openvpn/ticket/2</a><br></div><div style=3D"font-size:=
12.8px"><br></div><div style=3D"font-size:12.8px"><span style=3D"font-size:=
13px;color:rgb(0,0,0);font-family:Verdana,Arial,&quot;Bitstream Vera Sans&q=
uot;,Helvetica,sans-serif">As I mentioned,the custom TCP protocol(I called =
FakeTCP)</span><font color=3D"#000000" face=3D"Verdana, Arial, Bitstream Ve=
ra Sans, Helvetica, sans-serif">=C2=A0bypasses the TCP over TCP performance=
 issue.Its helpful when UDP is not avaliable(being=C2=A0</font><font color=
=3D"#000000" face=3D"Verdana, Arial, Bitstream Vera Sans, Helvetica, sans-s=
erif">blocked or being=C2=A0</font><span style=3D"font-size:13px;color:rgb(=
0,0,0);font-family:Verdana,Arial,&quot;Bitstream Vera Sans&quot;,Helvetica,=
sans-serif">throttled or not well supported by NAT devices</span><span styl=
e=3D"color:rgb(0,0,0);font-family:Verdana,Arial,&quot;Bitstream Vera Sans&q=
uot;,Helvetica,sans-serif">).</span><br></div><div style=3D"font-size:12.8p=
x"><span style=3D"color:rgb(0,0,0);font-family:Verdana,Arial,&quot;Bitstrea=
m Vera Sans&quot;,Helvetica,sans-serif"><br></span></div><div style=3D"font=
-size:12.8px"><span style=3D"color:rgb(0,0,0);font-family:Verdana,Arial,&qu=
ot;Bitstream Vera Sans&quot;,Helvetica,sans-serif">This was your reply:</sp=
an></div><div style=3D"font-size:12.8px">&gt;<span style=3D"font-size:13px;=
color:rgb(0,0,0);font-family:Verdana,Arial,&quot;Bitstream Vera Sans&quot;,=
Helvetica,sans-serif">We are not going to implement it, though. OpenVPN ove=
r TCP is needed when you have nasty firewalls out there that do sequence nu=
mber checking and all that - and then your FakeTCP is not going to work eit=
her. If you have no firewalls in the way, OpenVPN over UDP works perfectly =
well (including &quot;through NAT&quot;).</span><br></div><div style=3D"fon=
t-size:12.8px"><span style=3D"color:rgb(0,0,0);font-family:Verdana,Arial,&q=
uot;Bitstream Vera Sans&quot;,Helvetica,sans-serif;font-size:13px"><br></sp=
an></div><div style=3D"font-size:12.8px"><font color=3D"#000000" face=3D"Ve=
rdana, Arial, Bitstream Vera Sans, Helvetica, sans-serif">Sorry,I cant get =
the logic behind the sentence.</font></div><div style=3D"font-size:12.8px">=
<br></div><div style=3D"font-size:12.8px"><font color=3D"#000000" face=3D"V=
erdana, Arial, Bitstream Vera Sans, Helvetica, sans-serif">UDP not avaliabl=
e is a much more common=C2=A0</font><span style=3D"color:rgb(0,0,0);font-fa=
mily:Verdana,Arial,&quot;Bitstream Vera Sans&quot;,Helvetica,sans-serif;fon=
t-size:13px">circumstance,while a</span><span style=3D"color:rgb(0,0,0);fon=
t-family:Verdana,Arial,&quot;Bitstream Vera Sans&quot;,Helvetica,sans-serif=
">=C2=A0nasty firewall which tracks everything of TCP is just a rare=C2=A0<=
/span><span style=3D"color:rgb(0,0,0);font-family:Verdana,Arial,&quot;Bitst=
ream Vera Sans&quot;,Helvetica,sans-serif;font-size:13px">circumstance.</sp=
an></div><div style=3D"font-size:12.8px"><span style=3D"color:rgb(0,0,0);fo=
nt-family:Verdana,Arial,&quot;Bitstream Vera Sans&quot;,Helvetica,sans-seri=
f;font-size:13px"><br></span></div><div style=3D"font-size:12.8px"><font co=
lor=3D"#000000" face=3D"Verdana, Arial, Bitstream Vera Sans, Helvetica, san=
s-serif">This method solves most of the troubles when UDP is not avaliable =
just except the nasty-firewall=C2=A0</font><span style=3D"color:rgb(0,0,0);=
font-family:Verdana,Arial,&quot;Bitstream Vera Sans&quot;,Helvetica,sans-se=
rif;font-size:13px">circumstance you mentioned.</span><br></div><div style=
=3D"font-size:12.8px"><br></div><div style=3D"font-size:12.8px"><span style=
=3D"color:rgb(0,0,0);font-family:Verdana,Arial,&quot;Bitstream Vera Sans&qu=
ot;,Helvetica,sans-serif;font-size:13px">It seems like you rejected a=C2=A0=
</span><font color=3D"#000000" face=3D"Verdana, Arial, Bitstream Vera Sans,=
 Helvetica, sans-serif">commonly workable feature for a rare circumstance.<=
/font></div><div style=3D"font-size:12.8px"><span style=3D"color:rgb(0,0,0)=
;font-family:Verdana,Arial,&quot;Bitstream Vera Sans&quot;,Helvetica,sans-s=
erif;font-size:13px"><br></span></div><div style=3D"font-size:12.8px"><span=
 style=3D"color:rgb(0,0,0);font-family:Verdana,Arial,&quot;Bitstream Vera S=
ans&quot;,Helvetica,sans-serif;font-size:13px">I tried to have a further di=
scussion with you by another reply in the Tracker,but you closed the issue =
without a word.</span></div><div style=3D"font-size:12.8px"><span style=3D"=
color:rgb(0,0,0);font-family:Verdana,Arial,&quot;Bitstream Vera Sans&quot;,=
Helvetica,sans-serif;font-size:13px"><br></span></div><div style=3D"font-si=
ze:12.8px"><span style=3D"color:rgb(0,0,0);font-family:Verdana,Arial,&quot;=
Bitstream Vera Sans&quot;,Helvetica,sans-serif;font-size:13px">I am okay=C2=
=A0</span><font color=3D"#000000" face=3D"Verdana, Arial, Bitstream Vera Sa=
ns, Helvetica, sans-serif">wheter or not</font><span style=3D"font-size:13p=
x;color:rgb(0,0,0);font-family:Verdana,Arial,&quot;Bitstream Vera Sans&quot=
;,Helvetica,sans-serif">=C2=A0the feature can be implemented.I just hope it=
s well=C2=A0</span><font color=3D"#000000" face=3D"Verdana, Arial, Bitstrea=
m Vera Sans, Helvetica, sans-serif">discussed and=C2=A0</font><span style=
=3D"font-size:13px;color:rgb(0,0,0);font-family:Verdana,Arial,&quot;Bitstre=
am Vera Sans&quot;,Helvetica,sans-serif">there is a convincing reason if it=
 cant be=C2=A0</span><span style=3D"font-size:13px;color:rgb(0,0,0);font-fa=
mily:Verdana,Arial,&quot;Bitstream Vera Sans&quot;,Helvetica,sans-serif">im=
plemented</span><span style=3D"font-size:13px;color:rgb(0,0,0);font-family:=
Verdana,Arial,&quot;Bitstream Vera Sans&quot;,Helvetica,sans-serif">.If thi=
s feature is acceptable I can make patches.</span></div><div style=3D"font-=
size:12.8px"><span style=3D"color:rgb(0,0,0);font-family:Verdana,Arial,&quo=
t;Bitstream Vera Sans&quot;,Helvetica,sans-serif;font-size:13px"><br></span=
></div><div style=3D"font-size:12.8px"><font color=3D"#000000" face=3D"Verd=
ana, Arial, Bitstream Vera Sans, Helvetica, sans-serif">If you dont have ti=
me to discuss with me,plz leave the ticket open for a few days,so that I ca=
n possibly=C2=A0get some more=C2=A0</font><span style=3D"color:rgb(0,0,0);f=
ont-family:Verdana,Arial,&quot;Bitstream Vera Sans&quot;,Helvetica,sans-ser=
if;font-size:13px">convincing</span><span style=3D"color:rgb(0,0,0);font-fa=
mily:Verdana,Arial,&quot;Bitstream Vera Sans&quot;,Helvetica,sans-serif;fon=
t-size:13px">=C2=A0feedback from others.</span></div><div style=3D"font-siz=
e:12.8px"><span style=3D"color:rgb(0,0,0);font-family:Verdana,Arial,&quot;B=
itstream Vera Sans&quot;,Helvetica,sans-serif;font-size:13px"><br></span></=
div><div style=3D"font-size:12.8px"><br></div><div style=3D"font-size:12.8p=
x"><span style=3D"color:rgb(0,0,0);font-family:Verdana,Arial,&quot;Bitstrea=
m Vera Sans&quot;,Helvetica,sans-serif;font-size:13px">Thanks.</span></div>=
</div>

--001a11c17d40c523660557ea9aaa--


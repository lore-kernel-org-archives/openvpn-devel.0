MIME-Version: 1.0
Date: Sat, 14 Jan 2012 16:36:13 -0500
Message-ID: <CAMaBZnHTP5SbPhf5sCGeE2E-zQOGFYhXFQRSh2t1mnNvZ0c3Wg@...278...>
From: Praetorian <praetoriancode@...277...>
Content-Type: multipart/alternative; boundary=bcaec53d550d4cb2d104b683c50d
Subject: [Openvpn-devel] Setup a test openvpn network with ipv6 payload
	between all sites.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--bcaec53d550d4cb2d104b683c50d
Content-Type: text/plain; charset=ISO-8859-1

I finally got around to doing that setup of my test network using the
openvpn debian snapshots and windows test installer.  The network consists
of 1 static ip debian 6 linux hub server and 3 dynamic ip debian 6 linux
remote sites and 2 dynamic ip windows (vista and win7) road warriors. After
working through some issues I have it all working with ip4v and ipv6 inside
the tunnels.  Below are some things that I noted along the way that might
make the setup easier for users.

#1 The openssl conf files are gziped in easyrsa 2.0 (would be nice if the
script decomressed them if it saw they were compressed) When you try to
./build-ca you get an error until you decompress the openssl config files,
this might not be an openvpn issue persay but users will see it came with
the package and probably complain.

#2 When building CA use different CommonName for CA crt and Server Crt in
How To / docs (avoids the error message about same signing ca.crt and
server.crt) There might have been a option to turn off that error message,
but if its noted to just use a different CommonName I found that alot
easier that finding how to turn off that checking.

#3 In OpenVpnGUI on the connect entry have it ask which *.opvn file to
connect to or all or if it could parse all the possible client files and
make a connect entry for each or all.

#4 Set max retires in windows cfg to like 5 (when set to infinute you can't
break out of it unless you kill the UI) I had an error in my config file
and it scrolled by at lighting speed trying to reconnect and it makes it
real hard to figure out what was wrong.

#5 Put ipv6 example entries into the config files so people can see where
they go as the excellent example configs already show now for ipv4 for
server and client configs.

#6 In linux client config file should be dev tun-ipv6 and not just tun-ipv6

I used the version from debian snapshots openvpn_2.3-debian2_i386.deb on
the linux hosts and the windows installer was the one from December 2011.

If you have any other questions about the setup or wish me to test
something,  Please let me know.

Wayne

--bcaec53d550d4cb2d104b683c50d
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

I finally got around to doing that setup of my test network using the openv=
pn debian snapshots and windows test installer. =A0The network consists of =
1 static ip debian 6 linux hub server and 3 dynamic ip debian 6 linux remot=
e sites and 2 dynamic ip windows (vista and win7) road warriors. After work=
ing through some issues I have it all working with ip4v and ipv6 inside the=
 tunnels. =A0Below are some things that I noted along the way that might ma=
ke the setup easier for users.<div>
<br></div><div><div>#1 The openssl conf files are gziped in easyrsa 2.0 (wo=
uld be nice if the script decomressed them if it saw they were compressed) =
When you try to ./build-ca you get an error until you decompress the openss=
l config files, this might not be an openvpn issue persay but users will se=
e it came with the package and probably complain.</div>
<div><br></div><div>#2 When building CA use different CommonName for CA crt=
 and Server Crt in How To / docs (avoids the error message about same signi=
ng ca.crt and server.crt) There might have been a option to turn off that e=
rror message, but if its noted to just use a different CommonName I found t=
hat alot easier that finding how to turn off that checking.</div>
<div><br></div><div>#3 In OpenVpnGUI on the connect entry have it ask which=
 *.opvn file to connect to or all or if it could parse all the possible cli=
ent files and make a connect entry for each or all. =A0</div><div><br></div>
<div>#4 Set max retires in windows cfg to like 5 (when set to infinute you =
can&#39;t break out of it unless you kill the UI) I had an error in my conf=
ig file and it scrolled by at lighting speed trying to reconnect and it mak=
es it real hard to figure out what was wrong. =A0</div>
<div><br></div><div>#5 Put ipv6 example entries into the config files so pe=
ople can see where they go as the excellent example configs already show no=
w for ipv4=A0for server and client configs.</div><div>=A0</div><div>#6 In l=
inux client config file should be dev tun-ipv6 and not just tun-ipv6</div>
</div><div><br></div><div>I used the version from debian snapshots=A0openvp=
n_2.3-debian2_i386.deb on the linux hosts and the windows installer was the=
 one from December 2011.</div><div><br></div><div>If you have any other que=
stions about the setup or wish me to test something, =A0Please let me know.=
</div>
<div><br></div><div>Wayne=A0</div>

--bcaec53d550d4cb2d104b683c50d--


MIME-Version: 1.0
References: <20210825040122.14244-1-selva.nair@...277...>
 <20210825210232.22509-1-selva.nair@...277...>
 <20210825210232.22509-2-selva.nair@...277...>
In-Reply-To: <20210825210232.22509-2-selva.nair@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 7 Sep 2021 18:27:17 -0400
Message-ID: <CAKuzo_gRwdJorW-Z6rndVJcTmAsgLUcZiE9cDwoDxZULy3W4bw@...278...>
Content-Type: multipart/alternative; boundary="000000000000ea128205cb6f4d42"
Subject: Re: [Openvpn-devel] [PATCH v2 2/3] Permit unlimited connection
 entries and remotes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000ea128205cb6f4d42
Content-Type: text/plain; charset="UTF-8"

Hi,

While implementing this feature in the GUI, I have come across some
limitations of management-query-remote:

(i) Using a remote selected by the user from a list requires skipping
several remotes and accepting when the right one is reached. This is very
slow when there are more than a dozen remote entries: about ~1 second per
command.

Solution: Extend "remote SKIP" to take an optional parameter to skip "n"
entries by one command.

Use of "remote MOD" is not useful here as it does not support change of
protocol. It also has some "misbehaviour" due to the way resolved addresses
are cached.

(ii) remote-entry-get introduced here needs to be extended to support
requesting multiple or all remote entries in one command.

Please ignore the current version. v3 is coming.

Selva

--000000000000ea128205cb6f4d42
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,</div><div dir=3D"ltr"><br></div><div>=
While implementing this feature in the GUI, I have come across some limitat=
ions of management-query-remote:</div><div><br></div><div>(i) Using a remot=
e selected by the user from a list requires skipping several remotes and ac=
cepting when the right one is reached. This is very slow when there are mor=
e than a dozen remote entries: about ~1 second per command.</div><div><br><=
/div><div>Solution: Extend &quot;remote SKIP&quot; to take an optional para=
meter to skip &quot;n&quot; entries by one command.</div><div><br></div><di=
v>Use of &quot;remote MOD&quot; is not useful here as it does not support c=
hange of protocol. It also has some &quot;misbehaviour&quot; due to the way=
 resolved addresses are cached.</div><div><br></div><div>(ii) remote-entry-=
get introduced here needs to be extended to support requesting multiple or =
all remote entries in one command.</div><div><br></div><div>Please ignore t=
he current version. v3 is coming.</div><div><br></div><div>Selva</div></div>

--000000000000ea128205cb6f4d42--


MIME-Version: 1.0
From: Selva Nair <selva.nair@...277...>
Date: Tue, 10 Jan 2023 16:42:50 -0500
Message-ID: <CAKuzo_g3qfaAB62SVxGPhjqan0+QPCNz6D1+EjRS6OL17Z2x=g@...278...>
Content-Type: multipart/alternative; boundary="000000000000e0741b05f1efc409"
Subject: [Openvpn-devel] Conditions under which a connection entry could be
 disabled
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000e0741b05f1efc409
Content-Type: text/plain; charset="UTF-8"

Hi,

I see two situations under which a connection-entry (remote) could be
disabled while iterating through the list of remotes:
(i) --proto-force is in effect : configs not matching with the forced
protocol are disabled
(ii) --http-proxy-override : UDP profiles get disabled.
This looks like an unused option. Is it dead code no longer in use?

Are there any other cases?

I'm trying to get this info into the GUI for handling
"--management-query-remote".  Selecting a disabled entry from the UI would
lead to erratic behaviour. Ideally this info (CE_DISABLED state) should be
included in the response to  "remote-entry-get" command, but too late for
that to happen in 2.6. It didn't occur to me when that command was
implemented.

We now have a config-parser in the GUI and can get the info from the config
file if we know for sure what conditions lead to the flag CE_DISABLED.

Thanks,

Selva

--000000000000e0741b05f1efc409
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I see two situations under which a =
connection-entry (remote) could be disabled=C2=A0while iterating through th=
e list of remotes:</div><div>(i) --proto-force is in effect : configs not m=
atching with the forced protocol are disabled</div><div>(ii) --http-proxy-o=
verride : UDP profiles get disabled.</div><div>This looks like an unused op=
tion. Is it dead code no longer in use?=C2=A0</div><div><br></div><div>Are =
there any other cases?</div><div><br></div><div>I&#39;m trying to get this =
info into the GUI for handling &quot;--management-query-remote&quot;.=C2=A0=
 Selecting a disabled entry from the UI would lead to erratic behaviour. Id=
eally this info (CE_DISABLED state) should be included in the response to=
=C2=A0 &quot;remote-entry-get&quot; command, but too late for that to happe=
n in 2.6. It didn&#39;t occur to me when that command was implemented.</div=
><div><br></div><div>We now have a config-parser in the GUI and can get the=
 info from the config file if we know for sure what conditions lead to the =
flag CE_DISABLED.</div><div><br></div><div>Thanks,</div><div><br></div><div=
>Selva</div></div>

--000000000000e0741b05f1efc409--


MIME-Version: 1.0
References: <20210429171504.1081888-1-tincantech@...2282...>
 <0a188829-5a2c-362c-eb6f-61ffe657042d@...1227...>
 <_HUflzeIntsfJCr8BbPWvJqUE4YsZ4mnoeBBWWAWz5wXnrnJDSOgFNA8jXs4BX8W8rVR0-mttPOc8wCQ1Ou96EEB2a-ytMFQs33l9yGgwIU=@protonmail.com>
 <bQOH-0cnboEmpBYrhY8ZinjYni78M4fWH3z1_kKRQNVOA-LQOIomBj2wYz4yO1UfbHgSo5X__CZ_bC8sLGOs1USG_s0yXzJRgFbvVHfkTGs=@protonmail.com>
In-Reply-To: <bQOH-0cnboEmpBYrhY8ZinjYni78M4fWH3z1_kKRQNVOA-LQOIomBj2wYz4yO1UfbHgSo5X__CZ_bC8sLGOs1USG_s0yXzJRgFbvVHfkTGs=@protonmail.com>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 4 May 2021 15:41:20 -0400
Message-ID: <CAKuzo_jOFAP2j9rEz=7ZoZvk38a_qWCJHZnwVe=431xQJ3Th-A@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Add daemon_pid to --tls-crypt-v2-verify
 environment
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: tincantech <tincantech@...2282...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Tue, May 4, 2021 at 3:04 PM tincantech via Openvpn-devel
<openvpn-devel@lists.sourceforge.net> wrote:
>
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> Hi,
>
> =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original =
Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
> On Tuesday, 4 May 2021 13:43, tincantech via Openvpn-devel <openvpn-devel=
@lists.sourceforge.net> wrote:
>
> > Hi,
> >
> > =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Origina=
l Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
> > On Tuesday, 4 May 2021 11:50, Arne Schwabe arne@...1227... wrote:
> >
> > > Am 29.04.21 um 19:15 schrieb Richard T Bonhomme:
> > >
> > > > From: string vest stringvest88@...277...
> > > > Under Windows, programmatically retrieving the parent process ID of
> > > > the openvpn instance which called a script is practically impossibl=
e.
> > > > The only sensible way, currently available, is to write a PID file.
> > > > This patch adds a single integer variable, named daemon_pid, to the
> > > > script environment. The value of which is set to the openvpn process
> > > > ID that called the script.
> > > > Providing this variable via the running openvpn process is more sec=
ure,
> > > > faster and far less prone to user-error than using a PID file.
> > >
> > > Could you explain why you need the process ID of the daemon? I am try=
ing
> > > to figure out why that is needed. I also don't understand the secure =
in
> > > this context. What are you protecting yourself against? You are not
> > > protecting your script being called from a malicious program as that
> > > could lookup the PID of openvpn and just set the daemon_id variable.
> >
> > The reason I am using the process ID is as follows:
> >
> > When --tls-crypt-v2-verify is executed, it saves a file named:
> > $(certificate_serial_number}.${daemon_pid}
> > with data from the TLS-Crypt-V2 key metadata field, which can then
> > be read by the following scripts: --tls-verify and --client-connect.
> >
> > The --tls-verify and --client-connect script have:
> > $(certificate_serial_number} -> ${tls_serial_hex_0} and ${daemon_pid},
> > in their environment and can guarantee to pick-up the correct data file.
> >
> > This is OK for one running server but when there are more than one serv=
er
> > instance running, using a PID file becomes messy and cumbersome.
> >
> > The "secure" in this sense is that, having openvpn provide the PID is m=
uch
> > more reliable than relying on multiple PID files.
> >
> > Also, while it is "trivial" for *nix to retrieve the Parent PID, under
> > Windows, programmatically doing this is not "trivial" at all:
> >
> > PID:
> > https://docs.microsoft.com/en-us/windows-hardware/drivers/debugger/find=
ing-the-process-id
> > PPID:
> > https://stackoverflow.com/questions/7486717/finding-parent-process-id-o=
n-windows
> >
> > Therefore, barring any known security reasons for not providing the ope=
nvpn PID
> > to all scripts which it executes, it makes more sense to have openvpn p=
rovide
> > daemon_pid. The only script currently missing this data is --tls-crypt-=
v2-verify
> > (And probably --learn-address but I have not tested that).
> >
>
> Due to the inordinate resistance this patch has received, consider this m=
y official
> withdrawal.  I hereby NACK.

Resistance is a good thing -- it means people are considering your
patch seriously and are asking questions in earnest.

I've had patches that languished for  years and finally merged,
without batting an eye.. Except for an occasional gentle nudge (say
once a year), and some patience.


Selva


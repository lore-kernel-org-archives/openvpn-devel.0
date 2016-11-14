Resent-To: undisclosed-recipients:;
Resent-Message-ID: <evtCdvY8qGL4-N9sv4lpMtaTn@...2190...>
References: <1476996158-5390-1-git-send-email-davids@...515...>
	<1478950738-12861-1-git-send-email-davids@...515...>
	<e7f7340f-947e-ec15-37bf-9db1fb33ff11@...277...>
	<44a5aeb9-1fc1-ebd9-960e-cbea6680a8af@...2080...>
	<78424bc1-4d11-45b2-6532-bfff2c355620@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <f1f52ba6-4b2d-bf9a-ae71-38004755802a@...2080...>
Date: Mon, 14 Nov 2016 15:46:55 +0100
MIME-Version: 1.0
In-Reply-To: <78424bc1-4d11-45b2-6532-bfff2c355620@...277...>
Subject: Re: [Openvpn-devel] [PATCH v2] systemd: Improve the systemd unit
 files
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: debbie10t <debbie10t@...277...>, openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 14/11/16 15:06, debbie10t wrote:
>=20
>=20
> On 14/11/16 11:02, David Sommerseth wrote:
>> On 12/11/16 14:48, debbie10t wrote:
>>>=20
>>>=20
>>> On 12/11/16 11:38, David Sommerseth wrote:
>=20
>>>> +ExecStart=3D/usr/sbin/openvpn --suppress-timestamps --nobind
>>>> --config %i.conf
>=20
>>>> +ExecStart=3D/usr/sbin/openvpn --status
>>>> %t/openvpn-server/status-%i.log --status-version 2
>>>> --suppress-timestamps --config %i.conf
>=20
>>> Out of curiosity, is there a reason to put --config last ?
>>=20
>> Yes, that is to allow a sys-admin to easily change our defaults
>> without modifying the unit file.
>=20
> Um .. How ? .. I have not read anything which says this, A page
> explaining what you mean would be of great help.

As a massive example, you can do this:

 openvpn --config common.conf --config --crypto.conf --config tun0.conf

OpenVPN will first load and set everything in common.conf.  Then
it will load crypto.conf, and it can overwrites anything common.conf
have already set, and at last tun0.conf can override anything set in
both common.conf and crypto.conf.

This is due to how the option parser is coded.  Any options given on
the command line is the same as what is in the config file; with the
only difference that the config file options do not start with '--'.
The parser starts with the first option, parses that - including
loading configuration files and parsing them, then moves to the next
option, parses that one, and so one.

This also enables a variant of the command line above.  If tun0.conf
adds 'config common.conf' and 'config crypto.conf', it can be started
with only:  openvpn --config tun0.conf.  And there are some logic in
the OpenVPN option parser to avoid loading the same file more than once.
You can say this is a fairly traditional recursive behaviour:


- -- [pseudo code in pythonish] --------------

  options =3D {}
  parsed_configs =3D []

  def parse_config_file(filename):
       cfg =3D readfile(filename)

       for opt, val in cfg.split(" "):
           if opt =3D=3D 'config':
               if val in parsed_configs:
                  continue
               parse_config_file(val)
               parsed_configs.append(val)
           else:
               options[opt] =3D val

  parse_config_file('tun0.conf')

- ---------------------------------------------

This is the core concept when processing config files.  The logic is
far more complicated in OpenVPN as it considers command line arguments
as well into the same parsing logic.  Even options being sent by
PUSH_REPLY messages from server to clients passes through the exact
same option parser, which again can override settings from the
configuration file (if the option is allowed to be pushed, that is).

So to say this in a simple way: the most significant option is the
last occurrence of the option.  The earlier an option is listed, the
less significant it gets.

I don't think we have any other documentation explicitly mentioning
this.  I learnt these tricks when doing the technical review for the
"OpenVPN 2 Cookbook", and then later on starting to read the option
parser code in option.c in more detail.


> And related .. you cannot override --suppress-timestamps, once it
> is set it cannot be unset. IFAIK

You're right about --suppress-timestamps, as there exist no option to
reverse this one.  There are a few other scenarios where this is true
as well, like --nobind and --status (it cannot be disabled, only
modified to a different status file).  But the list is far shorter
than what it was.

I see that can be annoying for people insisting on using --log.  But
in this case I would rather recommend using the systemd journal
directly, that will cover most use cases and you have far better
control to look/grep through logs using search and range options to
journalctl.  And if that's not good enough, the systemd unit files we
ship are to be placed under /usr/lib/systemd/system/.  Currently they
can easily copy our unit file from there to /etc/systemd/system,
remove the --suppress-timestamp and be happy.  If this turns out to be
a bigger issue for the majority of users, we need to see which other
options we have.  Right now, I don't see this as a big issue though.


- --=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYKc5fAAoJEIbPlEyWcf3ynYgP/3jyeOKUVxXPwI70dvIaHH0B
yF60iTVhQMpiw06aJd9aXIGjzeiVpee2UA6pxFtEH/xT/CuoLgHIB84i8ZUAHTkk
UL1clY9IXz/fq1p7i/ZuKj3kQJBD2ppEFBvUOrM9PmmNJdiZlSoGO48eBww2hIpt
bRlH0Z64NMe37wSz0OyYvgY+jA2cOb/QNvRNi9yaxG+D3Ne+dw/ZRoaZs+ZqTA6M
4cV+9UZz7oNYgZyJB8tTiR+wOJLL9DbAVPEo1BwxYqHgoOlrLqsteNKSBwkiYBwl
+LEFoQdDTRJOdn3027RDjHhMSwsMktUGfwoV/FZYeQxBHzr+OvVNRN65IV7DWQcV
3VsRyCSdVuUEyyOdQjLAmKxYu4+BThe6DeoRqZ9e1HyneSCmoCEH3U9n/9fX+hsT
dvGlHA7JZfE0MXhNVCC3ev37lteo0MJNuxs4Hos5qqHutHoYar5d1NpfI0sP8ZbP
KqPPotyWFi5vFcnNoU9nJ+CwQrVhf6wYVtmsHghHkN9uie9RZvYA9+r41EEDNFDE
kH/l6uHT1qVNvVTmDRRLH2pTw4WL9VqUx/E6RjRvbkVIB8kIMqB6TJXcvfMUzIJA
DolDGYO+/stbBOvwUlQG0wDWocxJthO4LGGiSS94oksOBBtdV/fORS7bi2V2k6Eg
R4MsP+BM2oBN5hOxa80Q
=3DojjG
-----END PGP SIGNATURE-----


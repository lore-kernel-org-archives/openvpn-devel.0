MIME-Version: 1.0
References: <20260315184337.1541272-1-luca.boccassi@...277...>
 <20260315230620.1594780-1-luca.boccassi@...277...>
 <20260315230620.1594780-2-luca.boccassi@...277...>
 <b54e0eae-8fe2-420e-ba24-4d73ca50086d@...1227...>
 <CAMw=ZnQy+i0debrWv2ya=xy12_h1EmrRVfiuKEK9-aWZ6GJRoQ@...278...>
 <150f9ffe-bf48-43dd-86aa-b69961de1f99@...1227...>
 <CAMw=ZnQxvpy2Xx2rFHZCJprzx=SG_SC-i1O80noVRT7_BAOKJQ@...278...>
 <af798d10-e06c-46f7-a45d-378f76b9bafa@...1227...>
 <CAMw=ZnR7QBEo1tueV_mKnq=RJGNOtVfWoapmYiAy1WteX4rBoA@...278...>
 <4d2efb18-77e7-47a3-b5c4-b7f14d2f5f2a@...1227...>
In-Reply-To: <4d2efb18-77e7-47a3-b5c4-b7f14d2f5f2a@...1227...>
From: Luca Boccassi <luca.boccassi@...277...>
Date: Mon, 16 Mar 2026 20:50:18 +0000
Message-ID: <CAMw=ZnTw+4OJPuxOw5QM1yrOMLXpHjT87fJmwLrBSSyMWUk-5Q@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2 1/3] Increase TLS_CHANNEL_BUF_SIZE
 from 2048 to 8192
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

On Mon, 16 Mar 2026 at 12:30, Arne Schwabe <arne@...1227...> wrote:
>
> Am 16.03.26 um 13:17 schrieb Luca Boccassi:
> >
> > Oh it's even worse than that, I assure you :-) It's an internal
> > reimplementation, it does not use the open source server sadly. But it
> > is the openvpn protocol, and it works once the allowance for a large
> > password is made.
> >
> > I am trying to get the standard network-manager + openvpn setup to
> > work with it, to at least be spared from having to use the absolutely
> > horrendous proprietary client that comes with it.
> > In case you are curious, the network-manager-openvpn side is here:
> > https://gitlab.gnome.org/bluca/NetworkManager-openvpn/-/commits/entra_auth?ref_type=heads
> > With these changes, it works nicely.
> >
> > Of course I'm more than happy to get the client changes here in a form
> > that is acceptable to you, but would really appreciate guidance, as
> > you can tell I am completely new to this project. The only limitation
> > I have is that I can't change how the server works (I wish...), but on
> > the client side I am open to anything that works.
>
> Yeah the problem is that they made changes that are not really
> acceptable in general for our project. You basically would need a
> special azvpn mode in OpenVPN that is only activated via a configuration
> option or similar and that would also have a lot of code overhead to
> enable/disable this mode in various parts of OpenVPN. And we need some
> strong reason to include such a hack mode that we need to maintain then
> forever in our code base.
>
> I am afraid that for now using a specially patched version is probably
> easier/better to do.

Unfortunately a specially patched version cannot really work, as this
really needs to work with the packaged client in normal distros. Can't
tell other people to do their own building and patching and security
maintenance and so on...

But I'm not sure why a special mode would be needed in the first
place, with additional burden to support?

There are only 2 changes needed, and both have to do with ensuring the
password size that can already be supported (4096) actually works
through the stack. Right now the client you can install on Ubuntu or
Fedora or any other distro, where it is built with PKCS11 enabled,
takes 4k passwords already, so that part works, as the second patch of
the series is really a cleanup. The issue is that there are 2 places
in the client where this breaks:

1) The TLS buffer as per the first patch, as the client doesn't do
multiple passes, but instead expect a single write to the TLS layer to
be sufficient, but it supports 2k instead of the 4k that is the max
password size
2) The management protocol that network-manager uses to configure the
password at runtime, which takes 256 bytes at most in a command, as
per the third patch

So the goal here would be simply to ensure the client works with the
existing max password size.

Please let me know if I am missing something, but as far as I can
tell, I have tried to check for compatibility issues, but I could not
see one with the TLS buffer increase. I ran an unmodified 2.7.0
server, and a modified client, using TLS, and the client could connect
just fine to the unmodified server, even if the TLS buffer is larger -
it's just a buffer after all.

The only scenario I can think of that won't be compatible, is if
someone tries to send a password larger than 2K - but that is already
broken today? So in what way would that be a compatibility issue,
given it already doesn't work, despite the max password size already
being 4K? Is there a situation in which this would be a problem in a
way that it isn't today that I am missing?

This is the config I tested with, server:

dev tun
topology subnet
server 10.99.99.0 255.255.255.0
proto tcp-server
port 11940
ca /tmp/ovpn-compat-test/ca.crt
cert /tmp/ovpn-compat-test/server.crt
key /tmp/ovpn-compat-test/server.key
tls-auth /tmp/ovpn-compat-test/ta.key 0
cipher AES-256-GCM
auth SHA256
verb 4
keepalive 10 60
script-security 2
auth-user-pass-verify /bin/true via-env
username-as-common-name
verify-client-cert none

client:

client
dev tun
proto tcp-client
remote 127.0.0.1 11940
ca /tmp/ovpn-compat-test/ca.crt
cert /tmp/ovpn-compat-test/client.crt
key /tmp/ovpn-compat-test/client.key
tls-auth /tmp/ovpn-compat-test/ta.key 1
cipher AES-256-GCM
auth SHA256
auth-user-pass /tmp/ovpn-compat-test/userpass.txt
verb 4
nobind
connect-timeout 10

For the management protocol, if increasing the options size is not ok,
how about adding a new 'password-long' or somesuch option to the
protocol, that allows receiving a password that is up to the current
max of 4k?
Happy to work on this if it is preferable.

Thanks for your feedback!


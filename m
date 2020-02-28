References: <961fb2b3-ca10-1549-3ec8-a408e0072e2f@...515...>
 <CAFdgGSB4qc1KsfQB+67oub+P2J7pMPb6W6d6jZzgZzsB7m_0Og@...278...>
 <20191222183308.GP74723@...1296...>
 <CAFdgGSD5EzgzOqRCDaaBe45qUvqV-NmcKU3ZVmwOdBnw4MUSbg@...278...>
 <20191224083553.GD74723@...1296...>
From: Radu Hociung <radu.ovpndev@...2542...>
Message-ID: <ca5fdf6f-b731-7fed-70d3-90154bc40616@...2542...>
Date: Fri, 28 Feb 2020 14:18:20 -0500
MIME-Version: 1.0
In-Reply-To: <20191224083553.GD74723@...1296...>
Subject: Re: [Openvpn-devel] [Openvpn-users] Removing --disable-server
 option from OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

Hello,

On 24/12/2019 3:35 AM, Gert Doering wrote:
> On Tue, Dec 24, 2019 at 10:27:07AM +0300, Yevgeny Kosarzhevsky 
> wrote:
>>>>> We are considering removing the --disable-server option from
>>>>>  OpenVPN in 2.5.
> [..]
>> Yes I am using it to build some patched versions as well as 
>> no-replay and no-iv options to build plain tunnels.
> 
> But why?  For size reasons?
> 
> On the developer side, this option adds quite a bit of extra 
> maintenance effort (because quite often, a new patch works nice with
>  default option but breaks compilation with --disable-server), so 
> there needs to be a really good reason to keep the option.

I apologize for not responding to this query sooner. I only recently
started monitoring the openvpn mailing lists.

I would like to make the case for:
  a. Removing --disable-server build option
  b. Keeping and improving the P2MP_SERVER macro w/test-suite support
  c. Adding a P2P_CLIENT macro

I am advocating for separating the client and server personalities of
openvpn into distinct executables. Itemized recommendations at the end
of this long post.

Whether this option should be removed needs to depend not only on
community feedback, but also on whether it is the right choice for the
project. I think the chosen path, to remove P2MP_SERVER is the wrong choice.

The argument in favour or removing this build option is that some (less
diligently tested) patches break compilation of client-only binaries,
and this requires additional effort from the developers to resolve. It
is an argument favouring ease of integration over improving patch
quality, and ultimately software quality.

The reason for compilation breaking is not the existence of the option,
but that it is hard for the patch author to test two separate build
modes. It requires additional test effort on behalf of the patch author
to test both default build and client-only build. When this corner is
cut, defective patches result.

I believe the correct way to resolve this patch quality issue is to
build both the default binary and the client-only binary at the same
time, and have the test suite check both binaries in client roles. This
improved test suite would automate the verification done by patch
creators, and would not only eliminate the compilation breakage, but
also ensure that the client-only build is as well behaved as the default
build. It should be mandatory that patches pass "make check", and it is
up to you, the maintainers, to make that validation more stringent.

Without this additional verification, the behaviour of a client-only
build cannot be trusted by package maintainers or end users, and as a
result it's not useful to create an untested, client-only build.

The argument that embedded projects don't use the client-only build is
therefore a fallacy. They don't use client-only because it is untested,
not because a smaller binary is undesireable. Indeed, projects like
DDWRT use "dropbear" (a light ssh client/server) over OpenSSH sshd (a
full-featured SSH implementation) to save a few kilobytes. They also use
busybox instead of coreutils to save kilobytes.

However, whether a client-only is beneficial to embedded projects should
not be the measuring stick. Software quality should be.

Additionally, mature projects typically partition builds along purpose
lines. Eg. OpenSSH is built as "openssh-server" (sshd binary) and
"openssh-clients" (ssh binary). Bind is built as "bind" (named server
binary) and "bind-utils" (dig, etc). Many similar examples exist.
Is it that the traditional approach is not appropriate for openvpn? Does
the rest of the world have it wrong by not bundling the server and
client components of their software? Or is having a more thorough
test-suite undesireable for openvpn?

My interest in openvpn is mainly as an end user. I use it to build a
mesh network. It's not the best tool, but it's the closest to my needs,
and I've been able to add the missing features and improve reliability
to make it work well enough.

One of the more invaluable tools in adding the needed features was the
P2MP_SERVER define. It is a form of documentation, as it indicates which
parts of the codebase may be related to the server or client behaviour.
It has been very useful to me in navigating the source code.

The entire code base contains several event loops (tunnel_server_udp,
tunnel_server_tcp, tunnel_point_to_point), each with their separate
initialization sequences, I/O event waiting and I/O processing
functions. Not at all friendly to new contributors. The process has 3 or
4 distinct personalities dictated by "mode" and
"proto". The active personality is chosen at start time,
and the other two personalities are effectively dead code for the
duration. The dual/triple personality of this binary is ironically most
suitable for embedded devices which aim to implement more functionality
per kilobyte of flash memory, provided it makes sense to implement both
server and client personalities (busybox, dropbearmulti).

Reflecting the multi personality of the openvpn frankenbinary is the
manpage, which is frankly a bit of a mess. Many config options are
exclusive to one personality, and it's not always clear which. To a
first-time user of openvpn, it is daunting to get it running. Granted,
there are tutorials on getting up and running quickly by cutting and
pasting a command line, but that never works reliably for long, and
inevitably it becomes a recurring job to tweak a perpetually
broken/unreliable configuration.

The multiple personality is reflected in the config files. There
are separate server.conf and client.conf, serving different purposes.

The only purpose the "--disable-server" option serves it to remove the
ability to test the resulting binary (no useful "make check"). It should
be removed. On other projects, some components or features of the
software are truly optional, and can be disabled, eg. debug tooling,
documentation, adaptors, plugins, compatibility modes. But, in openvpn,
the server and the client binaries are core components. OpenSSH build is
a great example. There is no way to disable either client or server, as
it would not accomplish anything to not build a core component (other
than save less compile time than it takes to type this), but plenty of
ways to enable/disable features.

I would recommend that rather than removing the useful bit of
documentation that is P2MP_SERVER, the developers consider:

1. Restructure the source tree to split the src/openvpn code into
   src/{common,client,server}

2. Remove the configure --disable-server option, but add Makefile rules
   to build separate client, server and combined binaries, while
   also enabling distro maintainers to package openvpn-server and
   openvpn-client separately, from the same tarball. The combined
   binary can be used to build drop-in replacement packages.

3. Improve the test suite to verify the inter-operability of the
   3 binaries.

4. Separate the manpage into a server and a client edition.


Lastly, I am working on the MTU discovery patch, which is a RFC 4821
(Packetization Layer Path MTU Discovery) implementation, but part of the
patch is a test that is light-years ahead of what is currently available
in the openvpn git repo. It supports interop testing between
clients/servers of various versions, several handshaking and traffic
test patterns, a flexible framework for adding new test conditions,
regression testing, valgrind memcheck, and it does it on an honest
connection between a server and a client, with data traffic flowing
through the tunnel, every data packet being accounted for. So, my
recommendation #3 above may be coming your way soon.

Regards, and thank you for working on such a useful piece software.

Radu Hociung.


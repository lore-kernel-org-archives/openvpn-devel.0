From: Sampo Nurmentaus <audiopoppi-13@...22...>
Reply-To: <sampo.nurmentaus@...22...>
Subject: Re: [Openvpn-devel] Porting to an embedded linux
In-Reply-To: <Pine.LNX.4.33.0206131238520.28574-100000@...23...>
Message-ID: <Pine.LNX.4.33.0206131421210.28574-200000@...23...>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1705052949-1023971225=:28574"
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=openvpn-devel>
Date: Thu Jun 13 05:28:06 2002
To: sampo.nurmentaus@...22...
Cc: James Yonan <jim@...3...>, openvpn-devel@lists.sourceforge.net

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@...24... for more info.

--8323328-1705052949-1023971225=:28574
Content-Type: TEXT/PLAIN; charset=US-ASCII


Forget it,

It works now. I just found out
that setting the name of the device
couses the ioctl to fail.
Don't know if this is a
platform dependent issue or
a feature of the tun driver in 2.4.14

I suppose the latter since tun driver
is after all a quite high level one.


I also added a new optional command line
parameter to change the /dev/net/tun to
point somewhere else to avoid reflashing :-)

I included a patch agains openvpn-1.2.0
if someone else has similar problem.

Syntax is as fallows:
--tundev /tmp/tun


Thanks to you all for this beautiful software.

As an user space program it was mutch more
easy to port than freeswan, since kernel hackin'
would have required a million reflashings and
a great deal of serial debugging, since our
device has no display.


Sampo Nurmentaus

>
> Thanks James,
>
> It really helped. Simple recrosscompiling first kernel
> and then openvpn fixed it.
>
> And now I have faced a new one :-(
>
> ioctl on line 216 in tun.c (TUNSETIFF)  seems to fail
> complainin' about Invalid argument with errno 22.
> I use tun driver shipped with 2.4.14 kernel and
> if_tun.h which is identical to one in the kernel
> source tree.
>
> Any ideas?
>
>
> Sampo Nurmentaus
>
>
>
> > From: "Sampo Nurmentaus" <audiopoppi-13@...22...>
> > To: <openvpn-devel@lists.sourceforge.net>
> > Sent: Wednesday, June 12, 2002 8:31 AM
> > Subject: [Openvpn-devel] Porting to an embedded linux
> >
> >
> > > Hello folks,
> > >
> > >
> > > I have been recently busy porting openssl, openssh
> > > and openvpn to our embended linux environment
> > > build on etrax 100lx processor from axis communications.
> > >
> > > Openvpn's code was, thanks to you guys, quite easy to
> > > port but then I ran into problems when open vpn tries
> > > to ioctl tun device:
> > >
> > > ....
> > > 65: Static Decrypt: Cipher 'BF-CBC' initialized with 128 bit key
> > > 66: Static Decrypt: Using 160 bit message digest 'SHA1' for HMAC
> > > authentication
> > > 67: Data Channel MTU parms: mtu=1456 extra_frame=44 extra_buffer=44
> > > extra_tun=0
> > > 68: Cannot ioctl TUNSETIFF tun0: File descriptor in bad state (errno=77)
> > > 69: Exiting
> > >
> > >
> > > I have changed device to locate
> > > in /tmp/tun, but that shuld not couse this kind of problems.
> > > /dev is on flash image so it is easier to use /tmp for testing.
> > > I created the device as should with:
> > > mknod /tmp/tun c 10 200
> > >
> > > If I try to cat tun device read returns with the very same
> > > error text.
> > >
> > >  I compiled support to kernel (not as a module)
> > > so it should always be there.
> > >
> > >
> > > Any ideas?
> >
> > Sampo,
> >
> > See message below from a previous thread on openvpn-users, and with
> > references to vtun list.
> >
> > James
> >
> > >
> > > Thanx in advange,
> > >
> > > Sampo Nurmentaus
> >
> > James Yonan wrote:
> > >>Hi James,
> > >>
> > >>Thank you for your prompt and detailed reply.  What was happening
> > >>earlier was that I built openvpn first, then realized I needed to build
> > >>the tun/tap kernel module, so built that and then rebuilt openvpn - but
> > >>configure (god bless it) used the cached result of NOT finding if_tun.h.
> > >>  I cleared configure's cache and rebuilt it again - this time it found
> > >>"tun/tap v1.4".  Now I'm onto a new set of problems though.  Now I get:
> > >>
> > >>34: Cannot ioctl TUNSETIFF tun: File descriptor in bad state (errno=77)
> > >
> > >
> > > Though I've never seen this error personally, it has been talked about
> > > extensively on the vtun list (another tunneling daemon that uses the
> > TUN/TAP
> > > driver).
> > >
> > > Go to http://sourceforge.net/mailarchive/forum.php?forum_id=1826
> > >
> > > and search for "bad state".
> > >
> > > It appears to be caused by a mismatch between the tun/tap kernel module
> > and
> > > the kernel itself.
> > >
> > > What kernel version are you using?
> > >
> > > Because in versions 2.4.6 and higher, the TUN/TAP module is integral to
> > the
> > > kernel -- if you try to build an external version of the module, rather
> > than
> > > using the one already bundled, it will likely fail.
> >
> > Also I've read a few posts that suggest that /usr/src/linux needs to point
> > to headers that match the running kernel.  Depending on what Sean has, it
> > may be worthwhile to ensure all the various versions
> > (kernel/headers/tunTap) all match.
> >
> >
> >
> > _______________________________________________________________
> >
> > Sponsored by:
> > ThinkGeek at http://www.ThinkGeek.com/
> > _______________________________________________
> > Openvpn-devel mailing list
> > Openvpn-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> >
>
>
> _______________________________________________________________
>
> Don't miss the 2002 Sprint PCS Application Developer's Conference
> August 25-28 in Las Vegas - http://devcon.sprintpcs.com/adp/index.cfm?source=osdntextlink
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--8323328-1705052949-1023971225=:28574
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=openvpn-diff
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0206131527050.28574@...23...>
Content-Description: 
Content-Disposition: attachment; filename=openvpn-diff

NDdhNDgsNDkNCj4gI2luY2x1ZGUgPGFzc2VydC5oPg0KPiANCjU1M2M1NTUN
CjwgICBvcGVuX3R1biAob3B0aW9ucy0+ZGV2LCBvcHRpb25zLT5kZXZfdHlw
ZSwgJnR1bnRhcCk7DQotLS0NCj4gICBvcGVuX3R1biAob3B0aW9ucy0+dHVu
ZGV2LG9wdGlvbnMtPmRldiwgb3B0aW9ucy0+ZGV2X3R5cGUsICZ0dW50YXAp
Ow0KMTM3MmMxMzc0DQo8IAl0dW5jZmcgKG9wdGlvbnMuZGV2LCBvcHRpb25z
LmRldl90eXBlLCBvcHRpb25zLnBlcnNpc3RfbW9kZSk7DQotLS0NCj4gCXR1
bmNmZyAob3B0aW9ucy50dW5kZXYsb3B0aW9ucy5kZXYsIG9wdGlvbnMuZGV2
X3R5cGUsIG9wdGlvbnMucGVyc2lzdF9tb2RlKTsNCjEzODgsMTM4OWMxMzkw
LDEzOTkNCjwgCW5vdG51bGwgKG9wdGlvbnMuZGV2LCAidHVuL3RhcCBkZXZp
Y2UgKC0tZGV2KSIpOw0KPCANCi0tLQ0KPiAJew0KPiAJCW5vdG51bGwgKG9w
dGlvbnMuZGV2LCAidHVuL3RhcCBkZXZpY2UgKC0tZGV2KSIpOw0KPiAJCWlm
IChvcHRpb25zLnR1bmRldiA9PSBOVUxMKQ0KPiAJCSAgew0KPiAJCSAgICBh
c3NlcnQob3B0aW9ucy50dW5kZXYgPSANCj4gCQkJCShjaGFyICopIG1hbGxv
YyhzdHJsZW4oIi9kZXYvbmV0L3R1biIpKzEpKTsNCj4gCQkgICAgc3ByaW50
ZihvcHRpb25zLnR1bmRldiwiL2Rldi9uZXQvdHVuIik7DQo+IAkJICB9DQo+
IAl9DQo+ICAgICAgIA0KNTg3YTU4OCw1OTINCj4gICBlbHNlIGlmIChzdHJl
cSAocDEsICJ0dW5kZXYiKSAmJiBwMikNCj4gICAgIHsNCj4gICAgICAgKytp
Ow0KPiAgICAgICBvcHRpb25zLT50dW5kZXYgPSBwMjsNCj4gICAgIH0NCmRp
ZmYgLXIgb3BlbnZwbi0xLjIuMC9vcHRpb25zLmggYXhpcy9kZXZib2FyZF9s
eC9hcHBzL29wZW52cG4vb3B0aW9ucy5oDQo1M2E1NA0KPiAgIGNoYXIgKnR1
bmRldjsNCmRpZmYgLXIgb3BlbnZwbi0xLjIuMC9zeXNoZWFkLmggYXhpcy9k
ZXZib2FyZF9seC9hcHBzL29wZW52cG4vc3lzaGVhZC5oDQoxMzNjMTMzDQo8
IA0KLS0tDQo+IC8qDQoxMzZhMTM3LDEzOQ0KPiAqLw0KPiANCj4gI2luY2x1
ZGUgPC9ob21lL3NhYmUvYXhpcy9kZXZib2FyZF9seC9vcy9saW51eC9pbmNs
dWRlL2xpbnV4L2lmX3R1bi5oPg0KZGlmZiAtciBvcGVudnBuLTEuMi4wL3R1
bi5jIGF4aXMvZGV2Ym9hcmRfbHgvYXBwcy9vcGVudnBuL3R1bi5jDQoxODFj
MTgxDQo8IG9wZW5fdHVuIChjb25zdCBjaGFyICpkZXYsIGNvbnN0IGNoYXIq
IGRldl90eXBlLCBzdHJ1Y3QgdHVudGFwICp0dCkNCi0tLQ0KPiBvcGVuX3R1
biAoY29uc3QgY2hhciAqZGV2aWNlLGNvbnN0IGNoYXIgKmRldiwgY29uc3Qg
Y2hhciogZGV2X3R5cGUsIHN0cnVjdCB0dW50YXAgKnR0KQ0KMTg0YzE4NA0K
PCAgIHN0YXRpYyBjb25zdCBjaGFyIGRldmljZVtdID0gIi9kZXYvbmV0L3R1
biI7DQotLS0NCj4gLy8gIHN0YXRpYyBjb25zdCBjaGFyIGRldmljZVtdID0g
Ii90bXAvaGQvdHVuIjsNCjIxOGMyMTgNCjwgDQotLS0NCj4gICAgICAgDQoy
MjhjMjI4DQo8IHR1bmNmZyAoY29uc3QgY2hhciAqZGV2LCBjb25zdCBjaGFy
ICpkZXZfdHlwZSwgaW50IHBlcnNpc3RfbW9kZSkNCi0tLQ0KPiB0dW5jZmcg
KGNvbnN0IGNoYXIgKnR1bmRldixjb25zdCBjaGFyICpkZXYsIGNvbnN0IGNo
YXIgKmRldl90eXBlLCBpbnQgcGVyc2lzdF9tb2RlKQ0KMjMyYzIzMg0KPCAg
IG9wZW5fdHVuIChkZXYsIGRldl90eXBlLCAmdHQpOw0KLS0tDQo+ICAgb3Bl
bl90dW4gKHR1bmRldixkZXYsIGRldl90eXBlLCAmdHQpOw0KZGlmZiAtciBv
cGVudnBuLTEuMi4wL3R1bi5oIGF4aXMvZGV2Ym9hcmRfbHgvYXBwcy9vcGVu
dnBuL3R1bi5oDQo0MWM0MQ0KPCB2b2lkIG9wZW5fdHVuIChjb25zdCBjaGFy
ICpkZXYsIGNvbnN0IGNoYXIqIGRldl90eXBlLCBzdHJ1Y3QgdHVudGFwICp0
dCk7DQotLS0NCj4gdm9pZCBvcGVuX3R1biAoY29uc3QgY2hhciAqdHVuZGV2
LGNvbnN0IGNoYXIgKmRldiwgY29uc3QgY2hhciogZGV2X3R5cGUsIHN0cnVj
dCB0dW50YXAgKnR0KTsNCjQ3YzQ3DQo8IHZvaWQgdHVuY2ZnIChjb25zdCBj
aGFyICpkZXYsIGNvbnN0IGNoYXIgKmRldl90eXBlLCBpbnQgcGVyc2lzdF9t
b2RlKTsNCi0tLQ0KPiB2b2lkIHR1bmNmZyAoY29uc3QgY2hhciAqdHVuZGV2
LCBjb25zdCBjaGFyICpkZXYsIGNvbnN0IGNoYXIgKmRldl90eXBlLCBpbnQg
cGVyc2lzdF9tb2RlKTsNCg==
--8323328-1705052949-1023971225=:28574--


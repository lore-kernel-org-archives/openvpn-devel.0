MIME-Version: 1.0
In-Reply-To: <201007202308.30058.arthur@...1389...>
References: <4BC96D34.3000408@...515...> <201007192332.28862.arthur@...1389...>
	<4C44D0EB.4040703@...1114...>
	<201007202308.30058.arthur@...1389...>
From: JuanJo Ciarlante <jjo+ml@...410...>
Date: Thu, 23 Sep 2010 01:33:24 +0200
Message-ID: <AANLkTi=qkVmLxLPN=RqOg_6FyorH4RYM=XSQRiX20oEK@...278...>
Content-Type: multipart/mixed; boundary=00163642663dc594dc0490e194dd
Subject: Re: [Openvpn-devel] [Openvpn-users] Does --multihome work in latest
	OpenVPN release?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arthur Titeica <arthur@...1389...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--00163642663dc594dc0490e194dd
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Arthur,

Sorry for the immense delay, fortunately David ping()ed me on this
issue a few days ago.

On Tue, Jul 20, 2010 at 10:08 PM, Arthur Titeica <arthur@...1389...> wrote:
> On Tuesday 20 July 2010 01:25:47 David Sommerseth wrote:
>> On 19/07/10 22:32, Arthur Titeica wrote:
>> > On Sunday 02 May 2010 02:34:47 Peter Rabbitson wrote:
>> >> David Sommerseth wrote:
>> >>> On 01/05/10 21:39, Peter Rabbitson wrote:
>> >>>> Peter Rabbitson wrote:
>> >>>>> Peter Rabbitson wrote:
>> >>>>>> Samuli Sepp=E4nen wrote:
>> >>>>>>> Hi,
>> >>>>>>>
>> >>>>>>> Is someone successfully using the --multihome option on latest
>> >>>>>>> OpenVPN release? Or is this bug report still valid:
>> >>>>>>>
>> >>>>>>> <http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D562099>
>> >>>>>>
>> >>>>>> I am sorry I dropped the ball on testing that one. Will test the
>> >>>>>> coming night EST, and update.
>> >>>>>
>> >>>>> Looking more at the *debian* changelog, I see that there was a 3rd
>> >>>>> party ipv6 patch, which *could* have caused these problems. However
>> >>>>> it is not very easy for me to compile a "clean" openvpn on the
>> >>>>> multihomed server. Please let me know if this can be diagnosed in
>> >>>>> any other way, if not - I will find a way to test with vanilla
>> >>>>> openvpn.
>> >>>>
>> >>>> And unfortunately I was right (proven with the help of [1]) :(
>> >>>>
>> >>>> openvpn_2.1~rc20-1_i386.deb works
>> >>>> openvpn_2.1~rc20-2_i386.deb does not
>> >>>>
>> >>>> The only code-change between the two is:
>> >>>> =A0 * patches/jjo-ipv6-support.patch: Added ipv6 support. (Closes:
>> >>>> =A0 #307846)
>> >>>>
>> >>>> =A0 =A0 Patch from JuanJo Ciarlante.
>> >>>>
>> >>>> So this got to be the culprit. Attaching a -U10 diff between the
>> >>>> sources of both debian packages (not too long):
>> >>>>
>> >>>> [1] http://snapshot.debian.org/package/openvpn/
>> >>>
>> >>> Thank you very much, Peter, for tracking this one down! =A0One quest=
ion
>> >>> though. =A0Do you have configuration files and a "how to test it"
>> >>> description available which you could share with us? =A0That would h=
elp
>> >>> others to test it out as well - and it might help JJO to follow this
>> >>> one further.
>> >
>> > Hello,
>> > I'm using the latest git
>> > (git://openvpn.git.sourceforge.net/gitroot/openvpn/openvpn-testing.git)
>> > and multihome doesn't seems to work as far as I've tested.
>> >
>> > I have 2 links balanced with something like
>> >
>> > # ip route show
>> > ...
>> > default
>> >
>> > =A0 =A0 =A0 =A0 nexthop via x.x.x.x =A0dev eth2 weight 2
>> > =A0 =A0 =A0 =A0 nexthop via y.y.y.y =A0dev ppp5 weight 1
>> >
>> > and openvpn somehow fails with or without multihome.
>> >
>> > I'm not a programmer but I'dd gladly help with anything else (making
>> > tests, patches or even providing a test multihomed openvpn server).
>>
>> (moving over to the developers mailing list)
>>
>> Thank you for your testing! =A0If you put together some configuration
>> files for client and server and a clear description of how to test this,
>> that would save a lot of time for us when digging into the code.
>>
>> If your config files makes use of certificates, please make your test
>> environment work by using the keys in the source tree, located in the
>> sample-keys/ directory.
>>
>> Please try to make the config files for us as close to your setup as
>> possible. =A0This will really help us get closer to understand what
>> exactly happens.
>>
>> I have opened a bug ticket on this issue, to not forget this issue. =A0It
>> can be tracked here:
>> <https://community.openvpn.net/openvpn/ticket/28>
>>
>> Please report back with configuration files and a description of how to
>> prepare an environment for reproducing this behaviour.
>>
>>
>
> Hello,
> I've managed to setup a test dual-homed server with the following configs:
>
> server: http://psw.ro/tmp/test-server.conf
> client: http://psw.ro/tmp/test-client.conf
>
> With verb 6 on the client after successfully connecting thru one of the l=
inks
> - =A0connecting thru the second link hangs for a period of ~10 minutes wi=
th the
> following log:
>
> client-log1: http://psw.ro/tmp/client-log1.log
>
> If needed I'll try to find some time to better describe my network setup.

I think I fixed it, is there a chance you could try recompiling openvpn
with the attached patch ?

Cheers!,

>
> Thanks.
>
> --
> Arthur Titeica
> PharmEc Software Constanta
>
> -------------------------------------------------------------------------=
-----
> This SF.net email is sponsored by Sprint
> What will you do first with EVO, the first 4G phone?
> Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
>

--=20
--JuanJo ; echo jAjo@...1263... | sed 's/[SPAM]//g'

--00163642663dc594dc0490e194dd
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0001-fix-multihome-for-ipv4-cmsg_len-must-compare-against.patch"
Content-Disposition: attachment; 
	filename="0001-fix-multihome-for-ipv4-cmsg_len-must-compare-against.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_geetx3nc1

RnJvbSAxYjk2YmFhOGZjOTY0YmZiYThiZmJhODdmMWUwZTFmYmFiZjBiNDdiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKdWFuSm8gQ2lhcmxhbnRlIDxqam8rbWxAZ29vZ2xlLmNvbT4K
RGF0ZTogVGh1LCAyMyBTZXAgMjAxMCAwMToxNTozNSArMDIwMApTdWJqZWN0OiBbUEFUQ0hdICog
Zml4IC0tbXVsdGlob21lIGZvciBpcHY0OiBjbXNnX2xlbiBtdXN0IGNvbXBhcmUgYWdhaW5zdCBp
bl9wa3RpbmZvCiAgIHNpemUsIG5vdCB0aGUgZnVsbCA0KzYgdW5pb24sIGFsc28gdXNlIHNhbmVy
IHZhcmlhYmxlIG5hbWVzLgoKLS0tCiBzb2NrZXQuYyB8ICAgMjcgKysrKysrKysrKysrKystLS0t
LS0tLS0tLS0tCiAxIGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL3NvY2tldC5jIGIvc29ja2V0LmMKaW5kZXggMjg4YjU4YS4uODEw
YmIyMyAxMDA2NDQKLS0tIGEvc29ja2V0LmMKKysrIGIvc29ja2V0LmMKQEAgLTI0MzYsNiArMjQz
Niw3IEBAIHByaW50X2xpbmtfc29ja2V0X2FjdHVhbF9leCAoY29uc3Qgc3RydWN0IGxpbmtfc29j
a2V0X2FjdHVhbCAqYWN0LAogCQl7CiAJCSAgc3RydWN0IG9wZW52cG5fc29ja2FkZHIgc2E7CiAJ
CSAgQ0xFQVIgKHNhKTsKKwkJICBzYS5hZGRyLmluNC5zaW5fZmFtaWx5ID0gQUZfSU5FVDsKIAkJ
ICBzYS5hZGRyLmluNC5zaW5fYWRkciA9IGFjdC0+cGkuaW40LmlwaV9zcGVjX2RzdDsKIAkJICBi
dWZfcHJpbnRmICgmb3V0LCAiICh2aWEgJXMpIiwgcHJpbnRfc29ja2FkZHJfZXggKCZzYSwgc2Vw
YXJhdG9yLCAwLCBnYykpOwogCQl9CkBAIC0yNzc5LDcgKzI3ODAsNyBAQCBsaW5rX3NvY2tldF9y
ZWFkX3RjcCAoc3RydWN0IGxpbmtfc29ja2V0ICpzb2NrLAogc3RydWN0IG9wZW52cG5faW40X3Br
dGluZm8KIHsKICAgc3RydWN0IGNtc2doZHIgY21zZ2hkcjsKLSAgc3RydWN0IGluX3BrdGluZm8g
cGk7CisgIHN0cnVjdCBpbl9wa3RpbmZvIHBpNDsKIH07CiAjaWZkZWYgVVNFX1BGX0lORVQ2CiBz
dHJ1Y3Qgb3BlbnZwbl9pbjZfcGt0aW5mbwpAQCAtMjc5MCw5ICsyNzkxLDkgQEAgc3RydWN0IG9w
ZW52cG5faW42X3BrdGluZm8KICNlbmRpZgogCiB1bmlvbiBvcGVudnBuX3BrdGluZm8gewotCXN0
cnVjdCBvcGVudnBuX2luNF9wa3RpbmZvIGNtc2dwaTsKKwlzdHJ1Y3Qgb3BlbnZwbl9pbjRfcGt0
aW5mbyBtc2dwaTQ7CiAjaWZkZWYgVVNFX1BGX0lORVQ2Ci0Jc3RydWN0IG9wZW52cG5faW42X3Br
dGluZm8gY21zZ3BpNjsKKwlzdHJ1Y3Qgb3BlbnZwbl9pbjZfcGt0aW5mbyBtc2dwaTY7CiAjZW5k
aWYKIH07CiAjcHJhZ21hIHBhY2soKQpAQCAtMjgxNSw3ICsyODE2LDcgQEAgbGlua19zb2NrZXRf
cmVhZF91ZHBfcG9zaXhfcmVjdm1zZyAoc3RydWN0IGxpbmtfc29ja2V0ICpzb2NrLAogICBtZXNn
Lm1zZ19uYW1lID0gJmZyb20tPmRlc3QuYWRkcjsKICAgbWVzZy5tc2dfbmFtZWxlbiA9IGZyb21s
ZW47CiAgIG1lc2cubXNnX2NvbnRyb2wgPSAmb3BpOwotICBtZXNnLm1zZ19jb250cm9sbGVuID0g
c2l6ZW9mIChvcGkpOworICBtZXNnLm1zZ19jb250cm9sbGVuID0gc2l6ZW9mIG9waTsKICAgYnVm
LT5sZW4gPSByZWN2bXNnIChzb2NrLT5zZCwgJm1lc2csIDApOwogICBpZiAoYnVmLT5sZW4gPj0g
MCkKICAgICB7CkBAIC0yODI2LDcgKzI4MjcsNyBAQCBsaW5rX3NvY2tldF9yZWFkX3VkcF9wb3Np
eF9yZWN2bXNnIChzdHJ1Y3QgbGlua19zb2NrZXQgKnNvY2ssCiAJICAmJiBDTVNHX05YVEhEUiAo
Jm1lc2csIGNtc2cpID09IE5VTEwKIAkgICYmIGNtc2ctPmNtc2dfbGV2ZWwgPT0gU09MX0lQIAog
CSAgJiYgY21zZy0+Y21zZ190eXBlID09IElQX1BLVElORk8KLQkgICYmIGNtc2ctPmNtc2dfbGVu
ID49IHNpemVvZiAob3BpKSkKKwkgICYmIGNtc2ctPmNtc2dfbGVuID49IHNpemVvZiAoc3RydWN0
IG9wZW52cG5faW40X3BrdGluZm8pKQogCXsKIAkgIHN0cnVjdCBpbl9wa3RpbmZvICpwa3RpID0g
KHN0cnVjdCBpbl9wa3RpbmZvICopIENNU0dfREFUQSAoY21zZyk7CiAJICBmcm9tLT5waS5pbjQu
aXBpX2lmaW5kZXggPSBwa3RpLT5pcGlfaWZpbmRleDsKQEAgLTI5MTQsMTUgKzI5MTUsMTUgQEAg
bGlua19zb2NrZXRfd3JpdGVfdWRwX3Bvc2l4X3NlbmRtc2cgKHN0cnVjdCBsaW5rX3NvY2tldCAq
c29jaywKICAgICB7CiAgICAgY2FzZSBBRl9JTkVUOgogICAgICAgewotICAgICAgICBzdHJ1Y3Qg
b3BlbnZwbl9pbjRfcGt0aW5mbyBvcGk7CisgICAgICAgIHN0cnVjdCBvcGVudnBuX2luNF9wa3Rp
bmZvIG1zZ3BpNDsKICAgICAgICAgc3RydWN0IGluX3BrdGluZm8gKnBrdGk7CiAgICAgICAgIG1l
c2cubXNnX25hbWUgPSAmdG8tPmRlc3QuYWRkci5zYTsKICAgICAgICAgbWVzZy5tc2dfbmFtZWxl
biA9IHNpemVvZiAoc3RydWN0IHNvY2thZGRyX2luKTsKLSAgICAgICAgbWVzZy5tc2dfY29udHJv
bCA9ICZvcGk7Ci0gICAgICAgIG1lc2cubXNnX2NvbnRyb2xsZW4gPSBzaXplb2YgKG9waSk7Cisg
ICAgICAgIG1lc2cubXNnX2NvbnRyb2wgPSAmbXNncGk0OworICAgICAgICBtZXNnLm1zZ19jb250
cm9sbGVuID0gc2l6ZW9mIG1zZ3BpNDsKICAgICAgICAgbWVzZy5tc2dfZmxhZ3MgPSAwOwogICAg
ICAgICBjbXNnID0gQ01TR19GSVJTVEhEUiAoJm1lc2cpOwotICAgICAgICBjbXNnLT5jbXNnX2xl
biA9IHNpemVvZiAob3BpKTsKKyAgICAgICAgY21zZy0+Y21zZ19sZW4gPSBzaXplb2YgKHN0cnVj
dCBvcGVudnBuX2luNF9wa3RpbmZvKTsKICAgICAgICAgY21zZy0+Y21zZ19sZXZlbCA9IFNPTF9J
UDsKICAgICAgICAgY21zZy0+Y21zZ190eXBlID0gSVBfUEtUSU5GTzsKICAgICAgICAgcGt0aSA9
IChzdHJ1Y3QgaW5fcGt0aW5mbyAqKSBDTVNHX0RBVEEgKGNtc2cpOwpAQCAtMjkzNCwxNSArMjkz
NSwxNSBAQCBsaW5rX3NvY2tldF93cml0ZV91ZHBfcG9zaXhfc2VuZG1zZyAoc3RydWN0IGxpbmtf
c29ja2V0ICpzb2NrLAogI2lmZGVmIFVTRV9QRl9JTkVUNgogICAgIGNhc2UgQUZfSU5FVDY6CiAg
ICAgICB7Ci0gICAgICAgIHN0cnVjdCBvcGVudnBuX2luNl9wa3RpbmZvIG9waTY7CisgICAgICAg
IHN0cnVjdCBvcGVudnBuX2luNl9wa3RpbmZvIG1zZ3BpNjsKICAgICAgICAgc3RydWN0IGluNl9w
a3RpbmZvICpwa3RpNjsKICAgICAgICAgbWVzZy5tc2dfbmFtZSA9ICZ0by0+ZGVzdC5hZGRyLnNh
OwogICAgICAgICBtZXNnLm1zZ19uYW1lbGVuID0gc2l6ZW9mIChzdHJ1Y3Qgc29ja2FkZHJfaW42
KTsKLSAgICAgICAgbWVzZy5tc2dfY29udHJvbCA9ICZvcGk2OwotICAgICAgICBtZXNnLm1zZ19j
b250cm9sbGVuID0gc2l6ZW9mIChvcGk2KTsKKyAgICAgICAgbWVzZy5tc2dfY29udHJvbCA9ICZt
c2dwaTY7CisgICAgICAgIG1lc2cubXNnX2NvbnRyb2xsZW4gPSBzaXplb2YgbXNncGk2OwogICAg
ICAgICBtZXNnLm1zZ19mbGFncyA9IDA7CiAgICAgICAgIGNtc2cgPSBDTVNHX0ZJUlNUSERSICgm
bWVzZyk7Ci0gICAgICAgIGNtc2ctPmNtc2dfbGVuID0gc2l6ZW9mIChvcGk2KTsKKyAgICAgICAg
Y21zZy0+Y21zZ19sZW4gPSBzaXplb2YgKHN0cnVjdCBvcGVudnBuX2luNl9wa3RpbmZvKTsKICAg
ICAgICAgY21zZy0+Y21zZ19sZXZlbCA9IElQUFJPVE9fSVBWNjsKICAgICAgICAgY21zZy0+Y21z
Z190eXBlID0gSVBWNl9QS1RJTkZPOwogICAgICAgICBwa3RpNiA9IChzdHJ1Y3QgaW42X3BrdGlu
Zm8gKikgQ01TR19EQVRBIChjbXNnKTsKLS0gCjEuNy4xCgo=
--00163642663dc594dc0490e194dd--


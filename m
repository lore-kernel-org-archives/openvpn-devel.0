Message-ID: <4C0F4620.7030100@...1369...>
Date: Wed, 09 Jun 2010 09:43:28 +0200
From: Martin Mokrejs <mmokrejs@...1369...>
MIME-Version: 1.0
References: <4BF14A59.2000200@...1369...>
	<4C0E6EAB.3040304@...1369...>
	<4C0F3F06.2030004@...1114...>
In-Reply-To: <4C0F3F06.2030004@...1114...>
Content-Type: multipart/mixed; boundary="------------080309060103000607040706"
Subject: Re: [Openvpn-devel] openvpn-2.1.0-r1: easy-rsa tools creates broken
 client CERTs unusable for TLS
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------080309060103000607040706
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

David Sommerseth wrote:
> On 08/06/10 18:24, Martin Mokrejs wrote:
>> Hi,
>>   I had a look into the original bug report I sent and the summary is this:
>> at some version openvpn implemented a more strict check for certificate
>> values and if teh cjeck fails one yields "unsupported certificate purpose"
>> message.
> 
>>   I figured out that few more allowed values have to be included in the
>> certificate so that openVPN does not complain anymore. Basically, the patch
>> synchronizes the current openVPN behavior with the easy-rsa/ tools.
> 
>>   Is it clearer now? I attached to the bugreport at Gentoo an older version
>> of the patch to hopefully help you better with understanding what I tried.
>> What I believe should happen that somebody documents better what requirements
>> are for the server/client certifices in openVPN. The patch(es) show what
>> fields you should describe in docs and some version of the patch be committed
>> over easy-rsa/openssl.cf as well (or loosen the checks back in openVPN sources).
>> Martin
> 
> Ahoj Martin,
> 
> Thanks a lot for your patch and your investigations!  That is very much
> appreciated!
> 
> Your issues was discussed in the last developers meeting (Thu June 3rd)
> and it is not clear to us why you experiences this problem.  I believe
> Jan Just Keiser told that he had quite recently tested out easy-rsa-2.0
> and he had no issues at all.
> 
> I am also running a OpenVPN server on a Gentoo box, even though on this
> box I'm using TinyCA, so it is not directly comparable.  Anyhow, the
> X509v3 extensions are not that far away from what I do see easy-rsa-2.0
> should normally set:
> 
>         X509v3 extensions:
>             X509v3 Basic Constraints:
>                 CA:FALSE
>             Netscape Cert Type:
>                 SSL Client, S/MIME, Object Signing
> 
> I do see however that you are having mentioned Netscape Cert Type in
> your bug report.
> 
> Could this be related to some trickery patches Gentoo does to OpenVPN or
> OpenSSL?  Or that it is related to the OpenSSL version?

I have no idea what is patched on Gentoo and why, but I found lots of those
"unsupported certificate purpose" reports through Google, with very few real
answers. I don't believe it is Gentoo specific.


On the client:
I use net-misc/openvpn-2.1.0-r1, I see there are two patches applying to
my systems (no IPv6 patch):
        epatch "${FILESDIR}/${PN}-2.1_rc13-peercred.patch"
        epatch "${FILESDIR}/${PN}-2.1_rc20-pkcs11.patch"
I use dev-libs/openssl-0.9.8n.

On the server:
net-misc/openvpn-2.1.0-r1
dev-libs/openssl-0.9.8n


> 
> Would you mind sharing your configuration files and information about
> the OpenSSL version you are using?

The client and server configs are attached.

Thanks,
Martin

> 
> 
> kind regards,
> 
> David Sommerseth
> 
> 
>>> Hi,
>>>
>>> We discussed your bug report in last week's public IRC meeting:
>>>
>>> <http://thread.gmane.org/gmane.network.openvpn.devel/3748>
>>>
>>> In a nutshell, we had difficulties understanding what is required to
>>> reproduce this bug. Unfortunately the discussion logs were lost so I
>>> can't be any more specific. Would you like help us understand this issue
>>> by chatting with our devs on #openvpn-devel@...1334...? Or
>>> alternatively by sending mail to openvpn-devel mailinglist:
>>>
>>> <http://sourceforge.net/mail/?group_id=48978>
>>>
>>> All the best,
>>>
>>> -- Samuli Seppänen Community Manager OpenVPN Technologies, Inc irc freenode net: mattock 
> 
>>> Martin Mokrejs wrote:
>>>> Hi,
>>>>   I think the easy-rsa/openssl.cnf file should be modified so thet client
>>>> CERTs would match current openVPN expectations. Please see my bug report
>>>> at http://bugs.gentoo.org/show_bug.cgi?id=320171 . For convenience, I am
>>>> attaching the patch here. Did I get it right what has to be done? Would
>>>> someone fix the HOWTO and FAQ documentation to describe the keyUsage
>>>> fields and what is actually required for what? There is too many hit
>>>> in google for "unsupported certificate purpose". ;)
> 
>> ------------------------------------------------------------------------------
>> ThinkGeek and WIRED's GeekDad team up for the Ultimate 
>> GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the 
>> lucky parental unit.  See the prize list and enter to win: 
>> http://p.sf.net/sfu/thinkgeek-promo
>> _______________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 
> 

--------------080309060103000607040706
Content-Type: text/plain;
 name="client.conf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="client.conf"

IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwojIFNhbXBs
ZSBjbGllbnQtc2lkZSBPcGVuVlBOIDIuMCBjb25maWcgZmlsZSAjCiMgZm9yIGNvbm5lY3Rp
bmcgdG8gbXVsdGktY2xpZW50IHNlcnZlci4gICAgICMKIyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIwojIFRoaXMgY29uZmlndXJhdGlvbiBjYW4gYmUg
dXNlZCBieSBtdWx0aXBsZSAjCiMgY2xpZW50cywgaG93ZXZlciBlYWNoIGNsaWVudCBzaG91
bGQgaGF2ZSAgICMKIyBpdHMgb3duIGNlcnQgYW5kIGtleSBmaWxlcy4gICAgICAgICAgICAg
ICAgIwojICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjCiMg
T24gV2luZG93cywgeW91IG1pZ2h0IHdhbnQgdG8gcmVuYW1lIHRoaXMgICMKIyBmaWxlIHNv
IGl0IGhhcyBhIC5vdnBuIGV4dGVuc2lvbiAgICAgICAgICAgIwojIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjCgojIFNwZWNpZnkgdGhhdCB3ZSBhcmUg
YSBjbGllbnQgYW5kIHRoYXQgd2UKIyB3aWxsIGJlIHB1bGxpbmcgY2VydGFpbiBjb25maWcg
ZmlsZSBkaXJlY3RpdmVzCiMgZnJvbSB0aGUgc2VydmVyLgpjbGllbnQKCiMgVXNlIHRoZSBz
YW1lIHNldHRpbmcgYXMgeW91IGFyZSB1c2luZyBvbgojIHRoZSBzZXJ2ZXIuCiMgT24gbW9z
dCBzeXN0ZW1zLCB0aGUgVlBOIHdpbGwgbm90IGZ1bmN0aW9uCiMgdW5sZXNzIHlvdSBwYXJ0
aWFsbHkgb3IgZnVsbHkgZGlzYWJsZQojIHRoZSBmaXJld2FsbCBmb3IgdGhlIFRVTi9UQVAg
aW50ZXJmYWNlLgo7ZGV2IHRhcApkZXYgdHVuCgojIFdpbmRvd3MgbmVlZHMgdGhlIFRBUC1X
aW4zMiBhZGFwdGVyIG5hbWUKIyBmcm9tIHRoZSBOZXR3b3JrIENvbm5lY3Rpb25zIHBhbmVs
CiMgaWYgeW91IGhhdmUgbW9yZSB0aGFuIG9uZS4gIE9uIFhQIFNQMiwKIyB5b3UgbWF5IG5l
ZWQgdG8gZGlzYWJsZSB0aGUgZmlyZXdhbGwKIyBmb3IgdGhlIFRBUCBhZGFwdGVyLgo7ZGV2
LW5vZGUgTXlUYXAKCiMgQXJlIHdlIGNvbm5lY3RpbmcgdG8gYSBUQ1Agb3IKIyBVRFAgc2Vy
dmVyPyAgVXNlIHRoZSBzYW1lIHNldHRpbmcgYXMKIyBvbiB0aGUgc2VydmVyLgo7cHJvdG8g
dGNwCnByb3RvIHVkcAoKIyBUaGUgaG9zdG5hbWUvSVAgYW5kIHBvcnQgb2YgdGhlIHNlcnZl
ci4KIyBZb3UgY2FuIGhhdmUgbXVsdGlwbGUgcmVtb3RlIGVudHJpZXMKIyB0byBsb2FkIGJh
bGFuY2UgYmV0d2VlbiB0aGUgc2VydmVycy4KcmVtb3RlIFhYLlhYLlhYLlhYIDExOTQKO3Jl
bW90ZSBteS1zZXJ2ZXItMiAxMTk0CgojIENob29zZSBhIHJhbmRvbSBob3N0IGZyb20gdGhl
IHJlbW90ZQojIGxpc3QgZm9yIGxvYWQtYmFsYW5jaW5nLiAgT3RoZXJ3aXNlCiMgdHJ5IGhv
c3RzIGluIHRoZSBvcmRlciBzcGVjaWZpZWQuCjtyZW1vdGUtcmFuZG9tCgojIEtlZXAgdHJ5
aW5nIGluZGVmaW5pdGVseSB0byByZXNvbHZlIHRoZQojIGhvc3QgbmFtZSBvZiB0aGUgT3Bl
blZQTiBzZXJ2ZXIuICBWZXJ5IHVzZWZ1bAojIG9uIG1hY2hpbmVzIHdoaWNoIGFyZSBub3Qg
cGVybWFuZW50bHkgY29ubmVjdGVkCiMgdG8gdGhlIGludGVybmV0IHN1Y2ggYXMgbGFwdG9w
cy4KcmVzb2x2LXJldHJ5IGluZmluaXRlCgojIE1vc3QgY2xpZW50cyBkb24ndCBuZWVkIHRv
IGJpbmQgdG8KIyBhIHNwZWNpZmljIGxvY2FsIHBvcnQgbnVtYmVyLgpub2JpbmQKCiMgRG93
bmdyYWRlIHByaXZpbGVnZXMgYWZ0ZXIgaW5pdGlhbGl6YXRpb24gKG5vbi1XaW5kb3dzIG9u
bHkpCnVzZXIgbm9ib2R5Cmdyb3VwIG5vYm9keQoKIyBUcnkgdG8gcHJlc2VydmUgc29tZSBz
dGF0ZSBhY3Jvc3MgcmVzdGFydHMuCnBlcnNpc3Qta2V5CnBlcnNpc3QtdHVuCgojIElmIHlv
dSBhcmUgY29ubmVjdGluZyB0aHJvdWdoIGFuCiMgSFRUUCBwcm94eSB0byByZWFjaCB0aGUg
YWN0dWFsIE9wZW5WUE4KIyBzZXJ2ZXIsIHB1dCB0aGUgcHJveHkgc2VydmVyL0lQIGFuZAoj
IHBvcnQgbnVtYmVyIGhlcmUuICBTZWUgdGhlIG1hbiBwYWdlCiMgaWYgeW91ciBwcm94eSBz
ZXJ2ZXIgcmVxdWlyZXMKIyBhdXRoZW50aWNhdGlvbi4KO2h0dHAtcHJveHktcmV0cnkgIyBy
ZXRyeSBvbiBjb25uZWN0aW9uIGZhaWx1cmVzCjtodHRwLXByb3h5IFtwcm94eSBzZXJ2ZXJd
IFtwcm94eSBwb3J0ICNdCgojIFdpcmVsZXNzIG5ldHdvcmtzIG9mdGVuIHByb2R1Y2UgYSBs
b3QKIyBvZiBkdXBsaWNhdGUgcGFja2V0cy4gIFNldCB0aGlzIGZsYWcKIyB0byBzaWxlbmNl
IGR1cGxpY2F0ZSBwYWNrZXQgd2FybmluZ3MuCm11dGUtcmVwbGF5LXdhcm5pbmdzCgojIFNT
TC9UTFMgcGFybXMuCiMgU2VlIHRoZSBzZXJ2ZXIgY29uZmlnIGZpbGUgZm9yIG1vcmUKIyBk
ZXNjcmlwdGlvbi4gIEl0J3MgYmVzdCB0byB1c2UKIyBhIHNlcGFyYXRlIC5jcnQvLmtleSBm
aWxlIHBhaXIKIyBmb3IgZWFjaCBjbGllbnQuICBBIHNpbmdsZSBjYQojIGZpbGUgY2FuIGJl
IHVzZWQgZm9yIGFsbCBjbGllbnRzLgpjYSBrZXlzL2NhLmNydAoKIyBnb3plci5lY3RvcGxh
c20ub3JnL2Jsb2cvYXJjaGl2ZS8uLi4vb3BlbnZwbi12ZXJpZnkuaHRtbApjZXJ0IGtleXMv
Y2xpZW50LmNydCAgIyBicm9rZW4gZHVlIHRvIGJ1ZyBpbiBvcGVuc3NsIG9yIGVhc3ktcnNh
PyAKa2V5IGtleXMvY2xpZW50LmtleQoKIyBWZXJpZnkgc2VydmVyIGNlcnRpZmljYXRlIGJ5
IGNoZWNraW5nCiMgdGhhdCB0aGUgY2VydGljYXRlIGhhcyB0aGUgbnNDZXJ0VHlwZQojIGZp
ZWxkIHNldCB0byAic2VydmVyIi4gIFRoaXMgaXMgYW4KIyBpbXBvcnRhbnQgcHJlY2F1dGlv
biB0byBwcm90ZWN0IGFnYWluc3QKIyBhIHBvdGVudGlhbCBhdHRhY2sgZGlzY3Vzc2VkIGhl
cmU6CiMgIGh0dHA6Ly9vcGVudnBuLm5ldC9ob3d0by5odG1sI21pdG0KIwojIFRvIHVzZSB0
aGlzIGZlYXR1cmUsIHlvdSB3aWxsIG5lZWQgdG8gZ2VuZXJhdGUKIyB5b3VyIHNlcnZlciBj
ZXJ0aWZpY2F0ZXMgd2l0aCB0aGUgbnNDZXJ0VHlwZQojIGZpZWxkIHNldCB0byAic2VydmVy
Ii4gIFRoZSBidWlsZC1rZXktc2VydmVyCiMgc2NyaXB0IGluIHRoZSBlYXN5LXJzYSBmb2xk
ZXIgd2lsbCBkbyB0aGlzLgojIFRoaXMgd2lsbCBibG9jayBjbGllbnRzIGZyb20gY29ubmVj
dGluZyB0byBhbnkgc2VydmVyIHdoaWNoIGxhY2tzIHRoZSBuc0NlcnRUeXBlPXNlcnZlciBk
ZXNpZ25hdGlvbiBpbiBpdHMgY2VydGlmaWNhdGUsIGV2ZW4gaWYgdGhlIGNlcnRpZmljYXRl
IGhhcyBiZWVuIHNpZ25lZCBieSB0aGUgY2EgZmlsZSBpbiB0aGUgT3BlblZQTiBjb25maWd1
cmF0aW9uIGZpbGUuCiMgbnMtY2VydC10eXBlIHNlcnZlci4gVGhpcyBpcyB0byBwcmVlbnQg
Ik1hbi1pbi10aGUtTWlkZGxlIiBhdHRhY2suCgojbnMtY2VydC10eXBlIHNlcnZlcgpyZW1v
dGUtY2VydC10bHMgc2VydmVyCgojIElmIGEgdGxzLWF1dGgga2V5IGlzIHVzZWQgb24gdGhl
IHNlcnZlcgojIHRoZW4gZXZlcnkgY2xpZW50IG11c3QgYWxzbyBoYXZlIHRoZSBrZXkuCiMg
R2VuZXJhdGVkIGJ5IGBvcGVudnBuIC0tZ2Vua2V5IC0tc2VjcmV0IHRhLmtleWAKdGxzLWF1
dGgga2V5cy90YS5rZXkgMQoKIyBTZWxlY3QgYSBjcnlwdG9ncmFwaGljIGNpcGhlci4KIyBJ
ZiB0aGUgY2lwaGVyIG9wdGlvbiBpcyB1c2VkIG9uIHRoZSBzZXJ2ZXIKIyB0aGVuIHlvdSBt
dXN0IGFsc28gc3BlY2lmeSBpdCBoZXJlLgpjaXBoZXIgQkYtQ0JDICAgICAgICAjIEJsb3dm
aXNoIChkZWZhdWx0KQo7Y2lwaGVyIEFFUy0xMjgtQ0JDICAgIyBBRVMKO2NpcGhlciBERVMt
RURFMy1DQkMgICMgVHJpcGxlLURFUwoKIyBFbmFibGUgY29tcHJlc3Npb24gb24gdGhlIFZQ
TiBsaW5rLgojIERvbid0IGVuYWJsZSB0aGlzIHVubGVzcyBpdCBpcyBhbHNvCiMgZW5hYmxl
ZCBpbiB0aGUgc2VydmVyIGNvbmZpZyBmaWxlLgpjb21wLWx6bwoKIyBTZXQgbG9nIGZpbGUg
dmVyYm9zaXR5Lgp2ZXJiIDMKCiMgU2lsZW5jZSByZXBlYXRpbmcgbWVzc2FnZXMKO211dGUg
MjAK
--------------080309060103000607040706
Content-Type: text/plain;
 name="server.conf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="server.conf"

dGxzLXNlcnZlcgoKIyBVc2UgdGhlIHNhbWUgc2V0dGluZyBhcyB5b3UgYXJlIHVzaW5nIG9u
CiMgdGhlIHNlcnZlci4KIyBPbiBtb3N0IHN5c3RlbXMsIHRoZSBWUE4gd2lsbCBub3QgZnVu
Y3Rpb24KIyB1bmxlc3MgeW91IHBhcnRpYWxseSBvciBmdWxseSBkaXNhYmxlCiMgdGhlIGZp
cmV3YWxsIGZvciB0aGUgVFVOL1RBUCBpbnRlcmZhY2UuCjtkZXYgdGFwCmRldiB0dW4KCiMg
V2luZG93cyBuZWVkcyB0aGUgVEFQLVdpbjMyIGFkYXB0ZXIgbmFtZQojIGZyb20gdGhlIE5l
dHdvcmsgQ29ubmVjdGlvbnMgcGFuZWwKIyBpZiB5b3UgaGF2ZSBtb3JlIHRoYW4gb25lLiAg
T24gWFAgU1AyLAojIHlvdSBtYXkgbmVlZCB0byBkaXNhYmxlIHRoZSBmaXJld2FsbAojIGZv
ciB0aGUgVEFQIGFkYXB0ZXIuCjtkZXYtbm9kZSBNeVRhcAoKIyBBcmUgd2UgY29ubmVjdGlu
ZyB0byBhIFRDUCBvcgojIFVEUCBzZXJ2ZXI/ICBVc2UgdGhlIHNhbWUgc2V0dGluZyBhcwoj
IG9uIHRoZSBzZXJ2ZXIuCjtwcm90byB0Y3Atc2VydmVyCnByb3RvIHVkcAoKIyBUaGUgaG9z
dG5hbWUvSVAgYW5kIHBvcnQgb2YgdGhlIHNlcnZlci4KIyBZb3UgY2FuIGhhdmUgbXVsdGlw
bGUgcmVtb3RlIGVudHJpZXMKIyB0byBsb2FkIGJhbGFuY2UgYmV0d2VlbiB0aGUgc2VydmVy
cy4KO3JlbW90ZSBYWC5YWC5YWC5YWCAxMTk0CjtyZW1vdGUgbXktc2VydmVyLTIgMTE5NAoK
IyBDaG9vc2UgYSByYW5kb20gaG9zdCBmcm9tIHRoZSByZW1vdGUKIyBsaXN0IGZvciBsb2Fk
LWJhbGFuY2luZy4gIE90aGVyd2lzZQojIHRyeSBob3N0cyBpbiB0aGUgb3JkZXIgc3BlY2lm
aWVkLgo7cmVtb3RlLXJhbmRvbQoKIyBLZWVwIHRyeWluZyBpbmRlZmluaXRlbHkgdG8gcmVz
b2x2ZSB0aGUKIyBob3N0IG5hbWUgb2YgdGhlIE9wZW5WUE4gc2VydmVyLiAgVmVyeSB1c2Vm
dWwKIyBvbiBtYWNoaW5lcyB3aGljaCBhcmUgbm90IHBlcm1hbmVudGx5IGNvbm5lY3RlZAoj
IHRvIHRoZSBpbnRlcm5ldCBzdWNoIGFzIGxhcHRvcHMuCnJlc29sdi1yZXRyeSBpbmZpbml0
ZQoKIyBNb3N0IGNsaWVudHMgZG9uJ3QgbmVlZCB0byBiaW5kIHRvCiMgYSBzcGVjaWZpYyBs
b2NhbCBwb3J0IG51bWJlci4KO25vYmluZAoKIyBEb3duZ3JhZGUgcHJpdmlsZWdlcyBhZnRl
ciBpbml0aWFsaXphdGlvbiAobm9uLVdpbmRvd3Mgb25seSkKdXNlciBub2JvZHkKZ3JvdXAg
bm9ib2R5CgojIFRyeSB0byBwcmVzZXJ2ZSBzb21lIHN0YXRlIGFjcm9zcyByZXN0YXJ0cy4K
cGVyc2lzdC1rZXkKcGVyc2lzdC10dW4KCiMgSWYgeW91IGFyZSBjb25uZWN0aW5nIHRocm91
Z2ggYW4KIyBIVFRQIHByb3h5IHRvIHJlYWNoIHRoZSBhY3R1YWwgT3BlblZQTgojIHNlcnZl
ciwgcHV0IHRoZSBwcm94eSBzZXJ2ZXIvSVAgYW5kCiMgcG9ydCBudW1iZXIgaGVyZS4gIFNl
ZSB0aGUgbWFuIHBhZ2UKIyBpZiB5b3VyIHByb3h5IHNlcnZlciByZXF1aXJlcwojIGF1dGhl
bnRpY2F0aW9uLgo7aHR0cC1wcm94eS1yZXRyeSAjIHJldHJ5IG9uIGNvbm5lY3Rpb24gZmFp
bHVyZXMKO2h0dHAtcHJveHkgW3Byb3h5IHNlcnZlcl0gW3Byb3h5IHBvcnQgI10KCiMgV2ly
ZWxlc3MgbmV0d29ya3Mgb2Z0ZW4gcHJvZHVjZSBhIGxvdAojIG9mIGR1cGxpY2F0ZSBwYWNr
ZXRzLiAgU2V0IHRoaXMgZmxhZwojIHRvIHNpbGVuY2UgZHVwbGljYXRlIHBhY2tldCB3YXJu
aW5ncy4KbXV0ZS1yZXBsYXktd2FybmluZ3MKCiMgU1NML1RMUyBwYXJtcy4KIyBTZWUgdGhl
IHNlcnZlciBjb25maWcgZmlsZSBmb3IgbW9yZQojIGRlc2NyaXB0aW9uLiAgSXQncyBiZXN0
IHRvIHVzZQojIGEgc2VwYXJhdGUgLmNydC8ua2V5IGZpbGUgcGFpcgojIGZvciBlYWNoIGNs
aWVudC4gIEEgc2luZ2xlIGNhCiMgZmlsZSBjYW4gYmUgdXNlZCBmb3IgYWxsIGNsaWVudHMu
CmNhIGtleXMvY2EuY3J0CmNlcnQga2V5cy9jbGllbnQuY3J0IGtleXMvc2VydmVyLmNydApr
ZXkga2V5cy9jbGllbnQua2V5IGtleXMvc2VydmVyLmtleQoKZGgga2V5cy9kaDIwNDgucGVt
CgpzZXJ2ZXIgMTkyLjE2OC4yNTEuMCAyNTUuMjU1LjI1NS4wCgprZWVwYWxpdmUgMTAgMTIw
CgojIFZlcmlmeSBzZXJ2ZXIgY2VydGlmaWNhdGUgYnkgY2hlY2tpbmcKIyB0aGF0IHRoZSBj
ZXJ0aWNhdGUgaGFzIHRoZSBuc0NlcnRUeXBlCiMgZmllbGQgc2V0IHRvICJzZXJ2ZXIiLiAg
VGhpcyBpcyBhbgojIGltcG9ydGFudCBwcmVjYXV0aW9uIHRvIHByb3RlY3QgYWdhaW5zdAoj
IGEgcG90ZW50aWFsIGF0dGFjayBkaXNjdXNzZWQgaGVyZToKIyAgaHR0cDovL29wZW52cG4u
bmV0L2hvd3RvLmh0bWwjbWl0bQojCiMgVG8gdXNlIHRoaXMgZmVhdHVyZSwgeW91IHdpbGwg
bmVlZCB0byBnZW5lcmF0ZQojIHlvdXIgc2VydmVyIGNlcnRpZmljYXRlcyB3aXRoIHRoZSBu
c0NlcnRUeXBlCiMgZmllbGQgc2V0IHRvICJzZXJ2ZXIiLiAgVGhlIGJ1aWxkLWtleS1zZXJ2
ZXIKIyBzY3JpcHQgaW4gdGhlIGVhc3ktcnNhIGZvbGRlciB3aWxsIGRvIHRoaXMuCiNucy1j
ZXJ0LXR5cGUgc2VydmVyCgojIElmIGEgdGxzLWF1dGgga2V5IGlzIHVzZWQgb24gdGhlIHNl
cnZlcgojIHRoZW4gZXZlcnkgY2xpZW50IG11c3QgYWxzbyBoYXZlIHRoZSBrZXkuCnRscy1h
dXRoIGtleXMvdGEua2V5IDAKCiMgU2VsZWN0IGEgY3J5cHRvZ3JhcGhpYyBjaXBoZXIuCiMg
SWYgdGhlIGNpcGhlciBvcHRpb24gaXMgdXNlZCBvbiB0aGUgc2VydmVyCiMgdGhlbiB5b3Ug
bXVzdCBhbHNvIHNwZWNpZnkgaXQgaGVyZS4KY2lwaGVyIEJGLUNCQyAgICAgICAgIyBCbG93
ZmlzaCAoZGVmYXVsdCkKO2NpcGhlciBBRVMtMTI4LUNCQyAgICMgQUVTCjtjaXBoZXIgREVT
LUVERTMtQ0JDICAjIFRyaXBsZS1ERVMKCiMgRW5hYmxlIGNvbXByZXNzaW9uIG9uIHRoZSBW
UE4gbGluay4KIyBEb24ndCBlbmFibGUgdGhpcyB1bmxlc3MgaXQgaXMgYWxzbwojIGVuYWJs
ZWQgaW4gdGhlIHNlcnZlciBjb25maWcgZmlsZS4KY29tcC1sem8KCiMgU2V0IGxvZyBmaWxl
IHZlcmJvc2l0eS4KdmVyYiAzCgojIFNpbGVuY2UgcmVwZWF0aW5nIG1lc3NhZ2VzCjttdXRl
IDIwCg==
--------------080309060103000607040706--


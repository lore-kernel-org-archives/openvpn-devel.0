MIME-Version: 1.0
In-Reply-To: <4F565A70.5050907@...1114...>
References: <4F4CE4FE.3010009@...515...>
	<1848924920.20120228183103@...449...>
	<CAOazyz0x4hKsREcGi+9TGc+AO0d+i1d5qbmPJ2hQfCsUbVanNQ@...278...>
	<319492303.20120228213418@...449...>
	<1331052472905814500@...1315...>
	<CAOazyz0K7NONN9uFsqD5_uF_xmApF7BUmE8Wg_tarejrf5aVbw@...278...>
	<1331055760398534500@...1315...>
	<CAOazyz2q-W7M8v3ubU1G=Wa2XLwfzqP2HCtH6tsLXfgxpXQ3BA@...278...>
	<4F565A70.5050907@...1114...>
Date: Tue, 6 Mar 2012 20:55:10 +0200
Message-ID: <CAOazyz3-H6KBcc2m5DuRwQsdiJuCZF7RbqnyvmisHUXBvZFUww@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] OpenVPN Management Interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

On Tue, Mar 6, 2012 at 8:41 PM, David Sommerseth
<openvpn.list@...1114...> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 06/03/12 19:26, Alon Bar-Lev wrote:
>> On Tue, Mar 6, 2012 at 7:42 PM, Russell Morris <openvpn@...1315...>
>> wrote:
>>> Hi,
>>>
>>>
>>>
>>> That makes sense - thanks! I'm not a security expert by any means,
>>> so the thread lost me when it diverged into this area ... :-(.
>>>
>>>
>>>
>>> At the risk of asking a stupid question (but that is my specialty
>>> ... :-)) - is there a conclusion of how to deal with this?
>>>
>>
>> This is not a stupid question at all. In fact this is the correct
>> question... The wrong question is the privilege separation.
>>
>> I rephrase the question: What is missing within openvpn to allow
>> proper UI management
>>
>> Goal: To be able to support OpenVPN in complete privilege separation
>> from the end-user, delegating user specific credentials.
>>
>> OpenVPN core tasks:
>>
>> 1. Run without end-user credentials in OpenVPN configuration, meaning:
>> (Side note: there is no reason not to support both client and server
>> in this mode.) a. For each session accept certificate via management
>> interface. b. Delegate signature operations to management interface.
>> Although this is already implemented but undocumented, it only support
>> RSA, needs to be extended to other algorithms such as EC.
>>
>> 2. Run without peer certificate validation in OpenVPN configuration,
>> meaning: a. Delegate peer-certificate validation to the management
>> interface. b. No need for CA, EKU, Subject, CRL etc in configuration.
>>
>> 3. Provide cross platform command-line tool to interact with the
>> management interface, this is the supported project tool. a. Support
>> passphrase. b. Support file based certificate/key (PKCS#1, PKCS#12).
>> c. Support CryptoAPI. d. Support PKCS#11. e. Support peer certificate
>> validation. f. Support basic logging. e. In future this simple CLI
>> may transform to simple UI (Qt, GTK), similar to wpa_supplicant's
>> wpa_cli.
> [...snip...]
>
> I like these thoughts a lot. =C2=A0It really makes a lot of sense.
>
> However, how will this approach make sure that malware don't use such a
> (new) openvpn service to redirect all Internet traffic via a third-party
> which can analyse everything happening? =C2=A0The malware would just be a
> unprivileged process accessing the management interface, just like the
> GUI, right?

There are several challenges...

1. Multi user computer - we need to make sure one user cannot use
another user credentials and not effect the other users. With changes
I suggested there is full solution for this.

2. Defend user's data from server - by pushing/running script and/or
altering the openvpn behavior.  With changes I suggested there is full
solution for this as long as openvpn runs under a different
unprivileged account.

3. Defend user's data from hacker that gains control over openvpn
daemon. Provided openvpn runs under its own unprivileged account,
hacker can redirect communications but cannot access files and other
resources.

Of course nothing can be done against hacker that gains privileged
account... This is out of the scope of openvpn.

Also nothing can be done against hacker that gains access to user's
account, as it can simply extract private key (if file based). Or
request signature (if hardware based).

>
> <conspiracy_thoughts>
> I'm just thinking this would be an interesting approach in some less open
> countries, where OpenVPN is used to get access to the real free Internet.
> =C2=A0Distributing a suitable malware on computers with this kind of Open=
VPN
> would be make them able to do such MITM attacks.
> </conspiracy_thoughts>

If there is <something> that runs at workstation it is way too late to
try and protect....

Alon.


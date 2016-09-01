References: <834c4ed9-af60-1f0b-091d-da0fafa6bd96@...2080...>
	<CAFHpkQEQUM7U40aYeKQy=rA7tiRcGxUrFxusOrLHhq-MfPUgrA@...278...>
	<3fda1204-41dc-39a2-4fe6-cad66cd86c88@...2080...>
	<CAKuzo_iNNRCqfn=+9nv_n25mUF7akOW_6cec_JhU6dMuaV4nqQ@...278...>
	<3511ca4d-1d4a-a674-9be8-0cfe9859264c@...2080...>
	<CAKuzo_jqjYAHC3FH9dcu4+6ZfmaBOB18D135fYGxfpp0h=FNyA@...278...>
	<6508e6cf-1807-f8b1-80d4-082b17b2f7c0@...515...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <ab534529-b3c9-2039-3634-ffa4fb98ea5e@...1147...>
Date: Thu, 1 Sep 2016 10:29:54 +0200
MIME-Version: 1.0
In-Reply-To: <6508e6cf-1807-f8b1-80d4-082b17b2f7c0@...515...>
Subject: Re: [Openvpn-devel] Modernising the management interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>, Selva Nair <selva.nair@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 01/09/16 09:41, Samuli Sepp=E4nen wrote:
> Il 01/09/2016 07:33, Selva Nair ha scritto:
>>
>> On Wed, Aug 31, 2016 at 7:19 PM, David Sommerseth
>> <openvpn@...2080...
>> <mailto:openvpn@...2080...>> wrote:
>>
>>      -----BEGIN PGP SIGNED MESSAGE-----
>>      Hash: SHA1
>>
>>      On 31/08/16 23:25, Selva Nair wrote:
>>      > Hi,
>>      >
>>      > On Wed, Aug 31, 2016 at 4:11 PM, David Sommerseth
>>      > <openvpn@...2080...
>>      <mailto:openvpn@...2080...>
>>      > <mailto:openvpn@...2080...
>>      <mailto:openvpn@...2080...>>> wrote:
>>      >
>>      >     > It is not being planned to remove the management interface.=
  If
>>      >     > D-Bus works well for everyone on all platforms, then we can=
 disc
>>      uss
>>      >     > what to do next.  But as of now, I have no plans to remove =
this
>>      >     > part of the code.
>>      >
>>      >
>>      > That's all what I wanted to hear -- as long as the management int=
erfac
>>      e
>>      > (MI) is not going anywhere, no need to panic, right? I like the s=
imple
>>      > design of the current MI that makes it so easy to debug over comm=
and
>>      > line, support on virtually any platform without external librarie=
s etc
>>      .
>>      > Even with D-Bus one has to still send messages specific to the
>>      > application and the UI developer has to learn a few new keywords.=
 Not
>>      > very different from the current state of affairs unless we have a=
 use
>>      > case that is not easy to support over the current MI. I have neve=
r use
>>      d
>>      > D-Bus so no idea of the status of Windows support -- I believe the
>>      > reference implementation as a windows port, not sure how well mai=
ntain
>>      ed
>>      > it is.
>>
>>      I noticed that the upstream D-Bus community have embraced the Windo=
ws
>>      port and included all fixes for Windows there.  So it is probably
>>      somewhat better maintained nowadays.  But I have not looked where to
>>      download things.
>>
>>      If I've understood some of the D-Bus docs correctly, it should also=
 be
>>      possible to use D-Bus without a "master daemon" running too, but th=
at
>>      needs to be investigated further.
>>
>>      No, no need to panic :)  But I think that GUI's may also have some
>>      advantages of using D-Bus too, such as getting a more instant
>>      notifications when something goes wrong, or if a user needs to
>>      re-authenticate.  But I am completely open to explore these areas a=
nd
>>      not set things to stone now.
>>
>>
>> My advice, just leave the management-interface alone, at least until a
>> real need for a different framework arises . It "ain't broke", so why
>> fix it?
>>
>> The amount of communication we need/have between OpenVPN and UI's is so
>> minimal that it shouldn't take more than an hour for a developer to
>> "learn" the current management "protocol". Replacing or even augmenting
>> it with D-Bus bringing in new dependency and a lot of bloat doesn't make
>> much sense; nor does it look worth the time and effort to me..
> The main benefit seems to be easing the management of clients from the
> server-side. This could prove useful when managing VPN servers that have
> large numbers of clients, for example in the VPN service provider
> use-case. Is that the primary use-case you're thinking of, David?

after reading this entire thread  I tend to agree with Selva (mostly).
Here's my recap/understanding:

- there is a desire to update the management interface , in order to more e=
asily manage clients from the server side. Adding=20
functionality using either D-Bus , REST or (god forbid) SOAP will cause ext=
ra libraries to be added - more bloat

- on the client side, the management interface is used (extensively) by the=
 client GUI to interact with OpenVPN. The client=20
needs to remain as small and light-weight as possible, with as few external=
 dependencies as possible (can you spell=20
'pkcs11-helper' ?) Thus, here, we have the desire to keep things the way th=
ey are, or at the very least, a strong and=20
understandable desire to NOT add any external libraries

So, the management interface suffers from schizophrenia: it must allow for =
full-blown interaction for large-scale server setups=20
and it must be small and light-weight for the client.  IMHO these requireme=
nts contradict each other. A possible solution would=20
be to have a separate management interface (or at least management interfac=
e *protocol*) for client and server. A counter=20
argument would then be to split the client and server code completely , so =
that all server support is removed from the OpenVPN=20
client, in order to make the client software even more light weight - is th=
at a route we want to take?

Therefore I tend to agree with Selva: this is a very messy problem, don't t=
ouch unless there's an absolute need to do so.

JM2CW,

JJK


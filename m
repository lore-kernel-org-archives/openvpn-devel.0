MIME-Version: 1.0
Sender: fabian@...1547...
In-Reply-To: <1404593.Apkr3x9kAi@...1526...>
References: <4F4CE4FE.3010009@...515...> <7855235.EvfmKnZP6h@...1526...>
	<CAP+U6t+ZUA3UpYfKms0Qr=-Cn1M-GP1EJtGybG0+j+O2xnfv7g@...278...>
	<1404593.Apkr3x9kAi@...1526...>
From: Fabian Knittel <fabian.knittel@...1547...>
Date: Wed, 29 Feb 2012 16:28:31 +0100
Message-ID: <CAP+U6t+-8n=fFk+QP0Dm-H9YijcssjZjOHOpU5pwkSrXt1+qMQ@...278...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3-alpha1 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Heiko Hund <heiko.hund@...1489...>
Cc: =?UTF-8?Q?Carsten_Kr=C3=BCger?= <C.Krueger@...448...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi Heiko,

2012/2/29 Heiko Hund <heiko.hund@...1489...>:
> On Wednesday 29 February 2012 14:07:01 Fabian Knittel wrote:
[...]
>> (There must be something missing, otherwise
>> I don't get why you call it "interactive service" ...?)
>
> It's interactive in contrast to the other already existing service, that just
> starts all openvpn connections that it finds at the time the service itself is
> started. I internally called that service automatic. The GUI and openvpn
> interact with the interactive service, hence the name. And partially because I
> couldn't come up with something that made more sense.

Ah, I see. My confusion stemmed from the fact that I don't know
much/anything about how OpenVPN is currently used on Windows.

>> Why does the "interactive service" need to start OpenVPN? Why not let
>> the GUI start OpenVPN and let OpenVPN connect to the "interactive
>> service"?
>
> The key point here is the inheritance of the client end of the named pipe
> that's being used to request privileged operations. If there would just be a
> named pipe anyone could connect to, anyone could modify i.e. the routing
> table. Something MS tries to prevent obviously.

Ah, I see. So when you say that the "working directory, command line
options and stdin input for openpvn" are passed in, the idea is that
this MUST not allow the GUI-user to manipulate the OpenVPN process to
send arbitrary commands down the named pipe. (I initially you were
saying "pass in the path to the OpenVPN exe, but now I understand that
this is not what you meant.)

To ensure this in classic Linux this would mean that the OpenVPN
process needs to run as a _different_ user than the GUI user or else
the GUI user could freely manipulate the program using, e.g. ptrace. I
know that similar manipulations are possible in Windows, so can you
protect the service-started OpenVPN-executable from such
manipulations? (And I also assume that _named_ pipes still allow you
to hide the name from some processes of the same user?) (I'm not an
experienced Windows programmer, so please excuse my ignorance...)

>> OTOH, if you're going to start OpenVPN as a service anyway,
>> it probably doesn't really make much of a difference. Although this
>> could mean that you can keep the GUI-facing side of OpenVPN identical
>> to what it is now... the "interactive service" would just be an
>> implementation detail of how openvpn performs its privileged
>> operations.
>
> I got lost at "going to start OpenVPN as a service anyway". Openvpn isn't
> started as a service, the service starts openvpn. Openvpn is not running with
> same token the service runs, but the token of the GUI that invoked the
> service.

I was mistakenly using "run in background" and "service" as synonyms.
Anyway, you explained why who-starts-who makes all of the difference,
so this point is moot.

>> Does creating a tun/tap device belong to the operations that need
>> special privileges under windows? If so, this sounds a lot like an
>> interface that might also allow splitting off most of the system
>> specific code ... as in, this could also work on Android, no?
>
> No, that example was a spin off to my lengthy and highly fictional
> NetworkManager story. =) Essentially you're right, though. It could be used as
> such. Usually I#d say that stuff that can be setup before privileges are
> dropped should be done at that time. Setting of routes can only be done after
> privdrop and that's the main use for the new interface.

Yes, that makes sense. Hypothetically, the tun/tap-opening part would
be something the "interactive service" would do before launching the
OpenVPN executable, based on the parameters given by the GUI.

Thanks for clarifying.

Cheers
Fabian


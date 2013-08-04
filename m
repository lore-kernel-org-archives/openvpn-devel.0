Message-ID: <51FEA1BF.9000905@...515...>
Date: Sun, 04 Aug 2013 12:47:27 -0600
From: James Yonan <james@...515...>
MIME-Version: 1.0
References: <kt8j7m$c5m$1@...1062...> <20130730145731.GW13127@...1152...>
	<20130730151406.GQ16543@...1296...>
	<51FA324F.1090108@...1147...>
	<20130801143058.GM16543@...1296...>
	<51FA79C6.1020405@...1147...>
In-Reply-To: <51FA79C6.1020405@...1147...>
Subject: Re: [Openvpn-devel] [Openvpn-users] why doesn't openvpn negotiate
 settings?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>

We've recently merged some patches allowing OpenVPN to negotiate certain 
settings (such as compression), but unfortunately at this time neither 
cipher nor auth directives can be negotiated in the 2.x branch.

The 3.0 branch has fixed this somewhat by having the client support 
cipher and auth directives that are pushed by the server (*).

However, to make cipher/auth negotiation really work, there are a few 
more things that are needed.  For one, the client would need to push a 
list of supported cipher/auth methods, so the server can choose a 
mutually supported combination.  Another possibility is to have OpenVPN 
leverage on the preexisting TLS ciphersuite negotiation, so as to use 
the same cipher/auth settings as TLS.

Some of this was discussed recently in the TLS versioning thread on 
openvpn-devel:

http://sourceforge.net/mailarchive/forum.php?thread_name=1CED409804E2164C8104F9E623B08B901455DE1C69%40FOXDFT02.FOX.local&forum_name=openvpn-devel

James

*  The 3.0 branch is currently used by the OpenVPN Connect clients for 
Android and iOS.  Source core for the core is available from 
http://staging.openvpn.net/openvpn3/

On 01/08/2013 09:07, Jan Just Keijser wrote:
> Hi Gert,
>
> Gert Doering wrote:
>> Hi,
>>
>> On Thu, Aug 01, 2013 at 12:02:55PM +0200, Jan Just Keijser wrote:
>>
>>> It should be possible to add negotiation without completely breaking
>>> backwards compatibility; right now, when a server pushes an option to
>>> the client that is unrecognized the client will print a warning but it
>>> will not abort. This could be used to push a 'negotation request' - if
>>> the client responds then a negotation phase can start , during which the
>>> encryption key, hashing cipher, MTU settings etc can be negotiated. If
>>> the client does not respond the server would need to assume that it's a
>>> 2.3 or older client.
>>>
>>
>> Maybe I'm a bit naive, but since the data layer cipher is independent of
>> the TLS cipher anyway, can't we just "push cipher xxx"?
>>
>> Or is push/pull crypted with the data layer cipher?
>>
>>
> good question and one that I've asked myself as well -  there seems to
> be something funny going on with the data layer cipher (or auth parm) .
> I remember that I tried making the cipher and auth settings pushable and
> failed miserably. The flow of when and how the data cipher (and digest)
> are set up seems to be complicated and may happen (partially) *before*
> the options are pushed.
> Perhaps someone else (JamesY?) can comment on this.
>
> cheers,
>
> JJK
>
>
>
> ------------------------------------------------------------------------------
> Get your SQL database under version control now!
> Version control is standard for application code, but databases havent
> caught up. So what steps can you take to put your SQL databases under
> version control? Why should you start doing it? Read more to find out.
> http://pubads.g.doubleclick.net/gampad/clk?id=49501711&iu=/4140/ostg.clktrk
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>


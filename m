Message-ID: <416D8561.3070900@...292...>
From: "Peter 'Luna' Runestig" <peter+openvpn@...292...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] PATCH[2/2]: Use certificates from MS Cert Store
 with CryptoAPI
References: <416D3018.4040704@...292...> <416D3C1D.6000403@...255...> <Pine.LNX.4.58.0410131057240.20018@...269...>
In-Reply-To: <Pine.LNX.4.58.0410131057240.20018@...269...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Oct 13 12:44:26 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: James Yonan <jim@...41...>
Cc: Didier Conchaudron <didier@...255...>, openvpn-devel@lists.sourceforge.net

On 2004-10-13 19:09, James Yonan wrote:
> On Wed, 13 Oct 2004, Didier Conchaudron wrote:
> 
>> You Swedish guys are really making amazing softwares!
>> 
>> I'm very pleased you add this patch because I plan to make it in few 
>> months! So I can *really* concentrate on my tcp server patch, which is 
>> really not ready.
>> 
>> I will test your patch with another smart card I plan to use later.
>> 
>> Thanks a lot for this wonderfull contribution!
> 
> Peter,
> 
> I second that -- thank you for a very cool patch!

Thank you guys for that! :-) That's a much better welcome than I
expected; usually, when a stranger (like me), pops up on a list, out of
the blue, with a patch, it's usually very much frowned upon...

> Now I have a couple questions:
> 
> Did you have trouble with OpenVPN's usage of VARARG macros and MSVC?  
> People have had trouble with this in the past.

Yes, the 'msg' macro doesn't work. And MSVC doesn't have '#warning ...'
either, so I had to hack around that, see the patch.

> Also... Would it be a lot of work to get your contribution to build with 
> MinGW/gcc?

I don't know. I spent a couple of hours, trying to work around MinGW's
limitations when it comes to CryptoAPI, but I just ended up in dead
ends. What I can't manage to do in MinGW, is to figure out what "crypto
provider" a given "certificate context" belongs to. Maybe someone else
can? But I already had the code working, for myself (since I am used to
MSVC, and used it to develop the thing), and I gave up. Between daily
job/kids/girlfriend, there's not enough time... ;-)

> I ask because as much as I think your patch will be appreciated by the 
> community, adding MSVC to the build dependency chain will throw up a big 
> hurdle for those of us who build binary installs for Windows.

Yeah, I understand that. For a while today, I thought of extending MinGW
to suit my needs. But that would also be a bit inconvenient, if you
would have to patch and rebuild MinGW, just to be able to build this
code. I don't know, maybe I'll look into it again in a few days, now my
girlfriends birthday, and the annual moose hunt is on the schedule. :-)

> James

Thanks again for your warm welcome, and thanks again for /your/ great code!

Cheers,
- Peter
-- 
Peter 'Luna' Runestig (fd. Altberg), Sweden <peter@...292...>
PGP Key ID: 0xD07BBE13
Fingerprint: 7B5C 1F48 2997 C061 DE4B  42EA CB99 A35C D07B BE13
AOL Instant Messenger Screen name: PRunestig
Yahoo! Messenger profile name: altberg


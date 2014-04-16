Message-ID: <534E92B8.5050800@...1516...>
Date: Wed, 16 Apr 2014 16:24:56 +0200
From: Holger Kummert <Holger.Kummert@...1516...>
MIME-Version: 1.0
References: <1397645317-20116-1-git-send-email-Holger.Kummert@...1516...>
	<20140416135626.GC16637@...1296...>
In-Reply-To: <20140416135626.GC16637@...1296...>
Subject: Re: [Openvpn-devel] Fixes for HTTP proxy authentication with NTLM
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net


Hello,

Am 16.04.2014 15:56, schrieb Gert Doering:
> Hi,
>
> On Wed, Apr 16, 2014 at 12:48:35PM +0200, Holger Kummert wrote:
>> Any opinions?
>
> First of all, a big thank you for taking this on :-) - there have been

you're welcome!

> a couple of bugs in our trac related to NTLM, but since none of the
> developers really understand NTLM auth or have means to test it, nothing
> ever happend.

It seems that at least one is related: #259. The patches are based on
current git master branch. Don't know if #94 is touched.

>
> I'll give the patch a thorough review in the next days and come back with
> questions...

I'm looking forward this :-)


Holger

>
> gert
>


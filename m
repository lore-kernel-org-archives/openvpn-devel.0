Message-ID: <534C137C.4050201@...1856...>
Date: Mon, 14 Apr 2014 18:57:32 +0200
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <20140413152613.GT16637@...1296...>
	<534B8A45.8040006@...1147...>
In-Reply-To: <534B8A45.8040006@...1147...>
Subject: Re: [Openvpn-devel] RFD: ssl library version numbers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 14-04-14 09:12, Jan Just Keijser wrote:
> Gert Doering wrote:
>> - if we report it, do we want to report it always (as IV_VER) or only
>>   if --push-peer-info is set?
>>   
> we're reporting the openvpn version info anyway, so adding the SSL lib 
> version would not change much; if it is only returned when 
> --push-peer-info is set then there shouldn't be any privacy/security 
> concerns, esp if the info is given *AFTER* the initial connection is 
> made (i.e. after the first certificate handshake).

My thoughts exactly. I think this is useful, but I do not want to tell
an eavesdropper whether I'm running a vulnerable SSL library. So, this
should really happen *after* the peer authentication, over a secure channel.

-Steffan


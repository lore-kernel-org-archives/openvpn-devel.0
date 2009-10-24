Message-ID: <4AE35940.9060604@...41...>
Date: Sat, 24 Oct 2009 13:45:04 -0600
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <jwvvdie3l5z.fsf-monnier+gmane.network.openvpn.devel@...1269...>
In-Reply-To: <jwvvdie3l5z.fsf-monnier+gmane.network.openvpn.devel@...1269...>
Subject: Re: [Openvpn-devel] FQDN for routes should expand to all IPs
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
To: Stefan Monnier <monnier@...1268...>
Cc: openvpn-devel@lists.sourceforge.net

Stefan Monnier wrote:
> I've posted a bug report at:
> 
> http://sourceforge.net/tracker/index.php?func=detail&aid=2872760&group_id=48978&atid=454719
> 
> since since I haven't heard any reaction for almost 2 weeks now
> (although the report includes a patch which works well, at least for
> me), I'm wondering whether it was the right place.  Should I send my
> patches here instead?

This is the right place to submit bug reports.

Having said that, your bug report seems more like a feature request 
since routing commands/APIs generally do not support DNS A-record 
expansion as a standard feature.

It's an interesting idea though, and one that makes sense, but I haven't 
seen any other requests for it.

James


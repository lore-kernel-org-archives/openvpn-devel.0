Reply-To: openvpn-devel@lists.sourceforge.net
References: <20181008181618.8976-2-arne@...1227...>
 <201810081847.w98IlDNo033724@...2054...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <d2d180e5-09dd-0d89-4cdf-135db8195934@...2080...>
Date: Tue, 9 Oct 2018 23:34:39 +0300
MIME-Version: 1.0
In-Reply-To: <201810081847.w98IlDNo033724@...2054...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Remove AUTO_USERID feature
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>, Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

On 08/10/18 21:47, Gert Doering wrote:
> Acked-by: Gert Doering <gert@...1296...>
> 
> For the reasons given - it's code that has not been activated anywhere
> in the last 5+ years, there is no way to turn it on by configure, and
> it's likely not working right on half the platforms.  And less #ifdef!
And to add a bit more background; we discussed this with James directly, who
also said this AUTO_USERID feature is not used anywhere he was aware of; most
likely for specific use case for a side project he was involved in.  Anyhow,
James didn't think this feature had any value any more.

Arne: Lately you've often forgotten to add -s to git commit.  Please double
check your patches in this regard.

-- 
kind regards,

David Sommerseth
OpenVPN Inc



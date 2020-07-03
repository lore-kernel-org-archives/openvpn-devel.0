References: <20200626082743.15397-1-gert@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <d98b6023-4f57-0a8a-5b97-ed35eda8aa3c@...2181...>
Date: Fri, 3 Jul 2020 19:11:04 +0200
MIME-Version: 1.0
In-Reply-To: <20200626082743.15397-1-gert@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] t_client.sh: correctly report all
 failed instances in summary
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Hi,

On 26/06/2020 10:27, Gert Doering wrote:
> t_client.sh reports a summary at the end:
> 
>   Test sets succeeded: none.
>   Test sets failed: 1 2 3 4 5.
> 
> for tests that are skipped due to the pre-test ping check ("vpn target
> IP must not ping before VPN ist started") the script forgot to add
> the instance number to the summary line.  Fixed.
> 
> Signed-off-by: Gert Doering <gert@...1296...>

Simple enough and pretty clear. This is the only FAIL case where we set
the exit code, print a message, but don't append the test to the
SUMMARY_FAIL.

This is fixed now.

I can't easily come up with a t_client instance that verifies this
failure, but I trust Gert to have done so after having spotted the issue.

Acked-by: Antonio Quartulli <a@...2181...>



-- 
Antonio Quartulli


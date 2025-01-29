Message-ID: <bf174ce0-c4a2-43de-acfb-f61cd01ebd7b@...1227...>
Date: Wed, 29 Jan 2025 12:44:25 +0100
MIME-Version: 1.0
References: <20250127235413.1925-1-smittals@...2857...>
Content-Language: en-GB
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20250127235413.1925-1-smittals@...2857...>
Subject: Re: [Openvpn-devel] [PATCH] Adding AWS-LC to the OpenVPN CI
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Shubham Mittal <smittals@...2857...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 28.01.25 um 00:54 schrieb Shubham Mittal:
> URL: https://github.com/OpenVPN/openvpn/pull/673
> Acked-by: Arne Schwabe <arne@...1227...>
> Signed-off-by: Shubham Mittal <smittals@...2857...>
> ---
>   .github/workflows/build.yaml | 61 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 61 insertions(+)
> 
This looks fine but should we also bring the rpath improvement that Gert 
mentioned and that you implmented in the README.asws-lc to this patch?

Arne


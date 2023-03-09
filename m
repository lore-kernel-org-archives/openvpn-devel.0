Message-ID: <2df2e528-870e-a1c2-0f90-f9cab71318c3@...1227...>
Date: Thu, 9 Mar 2023 23:31:59 +0100
MIME-Version: 1.0
References: <20230309210344.5763-1-a@...2181...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20230309210344.5763-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2] dco: don't use NetLink to exchange
 control packets
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
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net


Am 09.03.2023 um 22:03 schrieb Antonio Quartulli:
> Using NetLink for control messages did not work out as it did lead to
> kernel side buffer congestion during heavy client activity.
>
> With this patch DCO will redirect control packets directly to the
> transport socket without altering them, so that userspace can
> happily process them as usual.

Patch looks good and does what it promises.

I ran this through the torture test on Ubuntu 22.04 and Bookworm (Debian 
13) and saw no issues.

Acked-By: Arne Schwabe <arne@...1227...>



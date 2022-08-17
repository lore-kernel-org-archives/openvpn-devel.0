Message-ID: <961abfa6-b755-3f0b-531b-e1418ee78bee@...1227...>
Date: Wed, 17 Aug 2022 15:29:06 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <20220817130955.450-1-timo@...2669...>
 <20220817132302.538-1-timo@...2669...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20220817132302.538-1-timo@...2669...>
Subject: Re: [Openvpn-devel] [PATCH v2] Github Actions: update used actions
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
To: Timo Rothenpieler <timo@...2669...>, openvpn-devel@lists.sourceforge.net

Am 17.08.22 um 15:23 schrieb Timo Rothenpieler:
> In the case of the Microsoft action, this fixes security relevant issues according to their release notes:
> https://github.com/microsoft/setup-msbuild/releases
> 
> Unfortunately they don't appear to be following the usual scheme of v1 referring to all v1.x.x, but instead v1 just points to v1.0.0.
> 
> The primary change with all the Github-Provided actions is the switch to a more up-to-date NodeJS version (16). Not all that relevant when you just use the action as is, but on top of that, the old versions are in low-maintenance mode, and basically are considered obsolete.
> Github is actively migrating people to the latest ones via dependabot wherever they can.
>

Thanks for the quick update.

Acked-By: Arne Schwabe <arne@...1227...>

Arne


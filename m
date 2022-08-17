Message-ID: <8c3f454b-2190-182b-5e07-6e42bc153e65@...2669...>
Date: Wed, 17 Aug 2022 15:18:00 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220817130955.450-1-timo@...2669...>
 <93095e87-79f1-d1b3-2fb7-61d58308f06f@...1227...>
From: Timo Rothenpieler <timo@...2669...>
In-Reply-To: <93095e87-79f1-d1b3-2fb7-61d58308f06f@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Github Actions: update used actions
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

On 17/08/2022 15:12, Arne Schwabe wrote:
> Hey,
> 
> newest and greatest is always nice but could you give a bit more 
> rationale why we should update? The commit message is unfortunately not 
> giving any details.

In the case of the Microsoft action, it actually fixes security relevant 
issues according to their release notes:

https://github.com/microsoft/setup-msbuild/releases

Unfortunately they don't appear to be following the usual scheme of v1 
referring to all v1.x.x, but instead v1 just points to v1.0.0.


The primary change with all the Github-Provided actions is the switch to 
a more up-to-date NodeJS version (16). Not all that relevant when you 
just use the action as is, but on top of that, the old versions are in 
low-maintenance mode, and basically are considered obsolete.
Github is actively migrating people to the latest ones via dependabot 
wherever they can.




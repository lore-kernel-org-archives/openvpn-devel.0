References: <20200528235423.27416-1-arne@...1227...>
 <bba548e3-f796-f871-fd52-450b3b1cbdab@...2080...>
 <d75c8b24-127d-09bf-3fe3-95a3884fad73@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <72c1041e-35d2-255d-28d1-43794d1f87df@...2181...>
Date: Fri, 29 May 2020 16:26:29 +0200
MIME-Version: 1.0
In-Reply-To: <d75c8b24-127d-09bf-3fe3-95a3884fad73@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Add .git-blame-ignore-revs with
 reformat commits
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
To: Arne Schwabe <arne@...1227...>, David Sommerseth <openvpn@...2080...>, openvpn-devel@lists.sourceforge.net

Hi,

On 29/05/2020 16:21, Arne Schwabe wrote:
> Am 29.05.20 um 15:51 schrieb David Sommerseth:
>> On 29/05/2020 01:54, Arne Schwabe wrote:
>>> +# Merge 'reformatting' branch into master
>>> +1f004b2f06e987d73e48f7fd7b96b0b248274f58
>>
>> Are you sure this "merge" commit shouldn't be commit 81d882d5 instead?
>>
> 
> I am not sure to be honest, that is why I included both commits as
> ignoring the merge commit might be instead then showing the other commit.

merge commits are normally there to solve conflicts..or to do nothing.

The conflict might be related to the reformatting (so you think we may
want to hide it)...but I think we should not ignore it in any case as
resolving a conflict is potentially a source of bugs.

Regards,

-- 
Antonio Quartulli


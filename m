References: <20181007150413.1455-1-a@...2181...>
 <20200422092607.16050-1-a@...2181...>
 <b79cb4c4-b846-d07e-52ff-db9f3b2773ba@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <69990cda-fe76-3cf6-e0fd-f94baffe203b@...2181...>
Date: Mon, 27 Apr 2020 09:58:16 +0200
MIME-Version: 1.0
In-Reply-To: <b79cb4c4-b846-d07e-52ff-db9f3b2773ba@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v9] convert *_inline attributes to bool
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 27/04/2020 03:57, Arne Schwabe wrote:
> Am 22.04.20 um 11:26 schrieb Antonio Quartulli:
>> Carrying around the INLINE_TAG is not really efficient,
>> because it requires a strcmp() to be performed every
>> time we want to understand if the data is stored inline
>> or not.
>>
>> Convert all the *_inline attributes to bool to make the
>> logic easier and checks more efficient.
>>
> 
> Look through it. It is only a minor improvement but Antonio has been
> persistent enough and spend enough time to make 9 versions of this so I
> took the time to look through it:
> 
> Acked-By: Arne Schwabe <arne@...2555...>
> 
> The patch is not uncrustify clean at the moment. So uncrustify should be
> run on commit or we need a v10 of this patch.
> 
> The patch does not apply cleanly anymore: The test_tls_crypt.c part
> should be now.


I can send v10 with these adjustments.

Thanks for the review!


-- 
Antonio Quartulli


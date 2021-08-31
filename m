References: <20210811095853.27870-1-a@...2181...>
 <20210827190014.12640-1-a@...2181...>
 <aea78a7d-139a-c504-c1f5-99e6d7a92632@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <693cf327-06fb-ebea-8a73-7985402e4cc6@...2181...>
Date: Tue, 31 Aug 2021 14:10:16 +0200
MIME-Version: 1.0
In-Reply-To: <aea78a7d-139a-c504-c1f5-99e6d7a92632@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2] Remove support for PF (Packet Filter)
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
To: openvpn-devel@lists.sourceforge.net

Arne just reminded me that we also need some text for Changes.rst.

How about this?

 68 PF (Packet Filtering) support has been removed
 69     The built-in PF functionality has been definitely removed from
the code
 70     base. This feature wasn't really easy to use and was long
unmaintained.
 71     This implies that also ``--management-client-pf`` and any other
compiletime
 72     or runtime related option does not exist any longer.


Gert could you please add this when applying this patch?

Thanks!

On 31/08/2021 00:39, Arne Schwabe wrote:
> Am 27.08.21 um 21:00 schrieb Antonio Quartulli:
>> OpenVPN shipped a small packet filtering tool called PF. It has never
>> been straightforward as it required a plugin to work. On top of that,
>> keeping PF support, makes the code more complicated and increases the
>> maintenance cost of OpenVPN.
>>
>> PF itself is not actually maintained at all and there is little
>> motivation in keeping it alive.
>>
>> Some years ago an IPv6 extension for PF was proposed, but it was never
>> picked up for the reasons above.
>>
>> External (and more appropriate) tools can still be used to implement
>> packet filtering on the OpenVPN interface.
>>
>> Drop PF support for good.
>>
>> Note that IDs used for external communication (i.e. to the plugin
>> or management interface) have been commented out, but not removed, as
>> they should not be used in the future.
>>
>> v2:
>> * changed // to /* */
>> * changed "NOT IMPLEMENTED" to "REMOVED FEATURE"
>> * removed extra empty lines after removing ifdef blocks
>> * clarified on IRC that tls_final has to be removed and therefore that
>>   hunk is correct
>> * removed mi_prefix() function as it is now unused
>>
>> Cc: Arne Schwabe <arne@...1227...>
>> Signed-off-by: Antonio Quartulli <a@...2181...>
> 
> Acked-By: Arne Schwabe <arne@...1227...>
> 
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 

-- 
Antonio Quartulli


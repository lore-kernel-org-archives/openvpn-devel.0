References: <20201215164221.5995-1-arne@...1227...>
 <20210328120241.27605-1-arne@...1227...>
 <20210328120241.27605-2-arne@...1227...>
 <20210418101127.GX976@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <37911499-1ff6-e396-8cf2-3f90e763299d@...1227...>
Date: Sun, 18 Apr 2021 13:48:53 +0200
MIME-Version: 1.0
In-Reply-To: <20210418101127.GX976@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v2 2/2] Fix condition to generate
 session keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net


Am 18.04.2021 um 12:11 schrieb Gert Doering:
> Hi,
>
> On Sun, Mar 28, 2021 at 02:02:41PM +0200, Arne Schwabe wrote:
> [..]
>> @@ -2240,7 +2240,8 @@ error:
>>    * to the TLS control channel (cleartext).
>>    */
>>   static bool
>> -key_method_2_write(struct buffer *buf, struct tls_session *session)
>> +key_method_2_write(struct buffer *buf, struct tls_multi *multi,
>> +                   struct tls_session *session)
>>   {
> For master, this conflicts with commit 8fa8a17528c (compress migrate),
> which already introduces the "multi" parameter.  Master only needs the
> second hunk (documentation plus CAS_SUCCEEDED check).

I can resend it if you want but this should be a trivial conflict. Maybe 
even 3way merge might fix it. If you don't count this as trivial 
conflict (i.e. does the same as the other patch) then I can also resend it.

Arne



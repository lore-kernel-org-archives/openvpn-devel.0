References: <20210810061644.20353-1-maximilian.fillinger@...2507...>
 <364dc95f-d198-397b-3720-3c9dac9890ae@...1227...>
 <78db12b9f4824871aecf26c93b0daf89@...2507...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <b17c1b51-153e-e201-8fcd-5c3247b1103e@...2181...>
Date: Tue, 10 Aug 2021 14:55:59 +0200
MIME-Version: 1.0
In-Reply-To: <78db12b9f4824871aecf26c93b0daf89@...2507...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Replace deprecated mbedtls DRBG update
 function
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
To: Maximilian Fillinger <maximilian.fillinger@...2507...>, Arne Schwabe <arne@...1227...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 10/08/2021 14:51, Maximilian Fillinger wrote:
>> Normally we have patch v2 here and also a patch v2 in the subject (use
>> -v 2 when doing git format-patch) but for this small patch it is not a
>> problem.
> 
> I'll keep it in mind for next time!
> 
>> Apart from the fact that we might want to abort (M_FATAL) if this fails
>> instead basically ignoring the error and just log it, the change is
>> fine. Considering the return status was ignored before, this patch is
>> otherwise good. But failing also does not have any really bad impact...
> 
> I was thinking about making it fatal, but there's another place where
> personalizing random can fail that also only gives a warning. So that's what
> I went with. (I wouldn't be opposed to making them both fatal, though.)
> 

IMHO it's ok to keep WARN for now because, like pointed out, other parts
of the code path just warn in case of issues.

Just a few line above Max's change there is another failure treated with
a WARN only.


Therefore I'd stick to WARN unless a complete revamp is performed on the
entire codepath.

Regards,



-- 
Antonio Quartulli


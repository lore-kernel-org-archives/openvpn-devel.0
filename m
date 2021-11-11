Message-ID: <ca85bfca-3f4e-deba-9b50-4b4e3205e2ab@...1227...>
Date: Thu, 11 Nov 2021 21:29:40 +0100
MIME-Version: 1.0
References: <2cbc4ca6-81d5-2cde-2e64-a3b7440bcccd@...515...>
 <9e5cf3a4-b8b9-4b11-99cd-44c44e82035f@...515...>
 <CAKuzo_hugKDgxX8YAPfK7uawMyTC5oyYPmUmYeqoUTR2P8kKxA@...278...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <CAKuzo_hugKDgxX8YAPfK7uawMyTC5oyYPmUmYeqoUTR2P8kKxA@...278...>
Subject: Re: [Openvpn-devel] Summary of the community meeting (10th November
 2021)
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
To: Selva Nair <selva.nair@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>


Am 11.11.2021 um 21:04 schrieb Selva Nair:
> Quoting from meeting log:
>
>> (15:50:52) cron2: and the ERR_BUF_SIZE (21/21) is missing as well...
> This is not really a missing piece in the OpenSSl 3.0/deprecation
> patch set as the buffer size increase is not a necessity yet. The need
> for a larger buffer arises when we start sending undigested messages
> for signature to the management client: a feature planned as a part of
> the external-key provider patches to make PSS signature generation
> easier on Android.
>
> So, right now it's like a cart before the horse, though it could be
> argued as a refactoring/cleanup as well -- unrelated to OpenSSL 3.0
> though.


I saw that in the epki patchset and decided that it should it be merged 
as part as that.


Arne



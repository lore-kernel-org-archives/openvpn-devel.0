References: <20171110163946.7656-1-fkooman@...2318...>
 <63ccd0e3-491f-3fb3-e611-9b6674d3d501@...2298...>
From: =?UTF-8?Q?Fran=c3=a7ois_Kooman?= <fkooman@...2318...>
Message-ID: <aef485c7-f619-eaac-6534-0828ab9d41f5@...2318...>
Date: Sun, 12 Nov 2017 12:15:57 +0100
MIME-Version: 1.0
In-Reply-To: <63ccd0e3-491f-3fb3-e611-9b6674d3d501@...2298...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Implement "status 4" (JSON) for
 management interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

On 11/11/2017 04:55 PM, Gert van Dijk wrote:
> Hi François,

Hi Gert,

> This is not a full review, but as just discussed face-to-face, here are
> some points from me:

Thanks for taking the time to look at it!

> 1) Could we also please please enable this for non-management interface
> use case? I guess it's just adding the status version number 4 in
> option/config validator (and the manpage).

Yes, I will add this as well.

> 2) With 1), perhaps it would be more clear to use *version* in your
> message/description so that it's about the --status-version option, not
> the --status option.

This got confused because in the management interface (via telnet) you'd
use "status" and not "status-version".

> 3) I believe the output structure is not valid JSON with the "END"
> string at the end.

All (multiline) responses end with "END", so that's why I did that as
well. Ideally I'd construct a JSON object that does not include newlines
at all and just responds as:

SUCCESS: { ... }

> (FYI I'm about to upload a patch to include more documentation on the
> --status-version option and to include a new field as well.)

Great!

Cheers,
François


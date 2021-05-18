References: <TGB05j2zTgH3-jDRcHubPFmTAQrG1hHgF4XtWb8Ytc14RY1RFusKL-QJFkyzi6H849DfuoutjhVZfRkiqAhGyHs9lLnI5tnWKDpaOrRfQv8=@protonmail.com>
 <20210517153133.GH976@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <25d67947-a760-3e9c-7567-2e1b29837e0a@...1227...>
Date: Tue, 18 May 2021 14:19:10 +0200
MIME-Version: 1.0
In-Reply-To: <20210517153133.GH976@...1296...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] Feature request - Allow comments inside
 <peer-fingerprint> markers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, tincantech <tincantech@...2282...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 17.05.21 um 17:31 schrieb Gert Doering:
> Hi,
> 
> On Mon, May 17, 2021 at 02:57:32PM +0000, tincantech via Openvpn-devel wrote:
>> I think it would useful to allow comment inside the <peer-fingerprint> markers.
> 
> I've run across this as well, and share that sentiment.  It would be nice.
> 
> That said, I'm not sure how easy it is to implement (the inline-config
> parser is used for all inline stuff, not only for peer-fingerprint).
> 

We could implement it in the hash parser to skip the lines starting with #.

Arne


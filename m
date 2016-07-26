References: <20160725200452.GE78279@...1296...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <751417c6-5f9f-e0c7-ffae-fce7fa9baa4c@...1147...>
Date: Tue, 26 Jul 2016 04:09:16 +0200
MIME-Version: 1.0
In-Reply-To: <20160725200452.GE78279@...1296...>
Subject: Re: [Openvpn-devel] use of --cipher with no arguments?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

Hi Gert,

On 25/07/16 22:04, Gert Doering wrote:
> Hi,
>
> has anyone ever used "--cipher" without an argument?  If yes, what is the
> intended usage?  It sort of "tells openvpn we want crypto!" but does not
> go into detail about it...
>
> Normally, this would just be a random weird option, but I ran across
>
>    --cipher none --cipher
>
> which first tells openvpn "nah, we do not want anything!" and sets
> a pointer to NULL, and then tells openvpn "but please *do* use the
> ciphers already setup!", which core dumps.
>
> This is not remotely exploitable, so not a *security* issue, but a bit
> stupid nonetheless - so I propose we just throw out "--cipher" with
> no arguments (--cipher none, or --cipher bf-cbc would, of course,
> continue to work).
>
> Anyone having a good argument against it?  JJK, do you happen to know
> what this is about?
>
this is from even before my time ;)
I didn't even know that you could specify cipher without an argument - 
let's disable this (and I assume the same is true for --auth ?)

JJK



MIME-Version: 1.0
In-Reply-To: <20180130205821.GS69387@...1296...>
References: <6a3cabee-e9ea-bea6-cca7-d3f9672f292f@...515...>
 <CAKuzo_jTyA42EJtwcr5xsRRVbMy5WzPibbZHSPEa9piBJ14ozg@...278...>
 <20180130205821.GS69387@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 30 Jan 2018 16:13:05 -0500
Message-ID: <CAKuzo_jC4DTJmoerPUgPYqA86Bd840+Sn_ju_e10Q5z9Ad-q-g@...278...>
Subject: Re: [Openvpn-devel] Topics for the community meeting (Wed,
 31st Jan 2018)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Tue, Jan 30, 2018 at 3:58 PM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Tue, Jan 30, 2018 at 12:21:58PM -0500, Selva Nair wrote:
>> A quick comment regarding item 2 in topics:
>> > 2 mgmt version 2 / pk-sign and 2.4
>> >  Is this something we want in 2.4? If not, how's the GUI going to deal with 2.4 and master being different?"
>>
>> Unless 2.4 is getting EC cert external signing support, we do not need
>> this in there, do we?
>>
>> I think it shouldn't be a problem for UI's as the master will behave
>> the same way as 2.4 towards old UI's. New/updated UI's are expected to
>> first check the management version of the daemon, then optionally
>> announce version 2 support, and be prepared to handle old and
>> new-style requests.
>
> This is the part I was missing - that the GUI knows what version the
> openvpn.exe process can handle.  So a "master GUI" would send "version 2",
> while a "2.4 GUI" would see "openvpn.exe can only do 1" and send "version".
>
> Good - that basically concludes the topic for tomorrow :-) (unless someone
> convinces me that we want EC cert external signing in 2.4)
>
>> Anyway, "The Windows GUI" doesn't care as it does not handle signature
>> requests. Jonathan said the same about Tunneblick.
>
> Oh?  I missed that part.  So who is using --management-external-key, then,
> if neither of the "two main GUIs" are doing it?

I was surprised that Tunnelblick doesn't use it. May be just
Android... EduVPN was concerned about lack of TLS 1.2, so their UI
wants to use it?

On windows we have cryptoapicert that can handle software keys in
windows key-stores and hardware tokens. Though we'll implement this
"one day" just to be feature-complete :)

Selva


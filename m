From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Plug-in to modify payload flowing over tunnel
In-Reply-To: <20686C579479DC438276A726FE80CDAA020E05FC@...281...>
Message-ID: <Pine.LNX.4.58.0412031148450.10000@...41...>
References: <20686C579479DC438276A726FE80CDAA020E05FC@...281...>
MIME-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Fri Dec  3 10:53:12 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: satinders@...280...
Cc: openvpn-devel@lists.sourceforge.net

On Fri, 3 Dec 2004 satinders@...280... wrote:

> Hi,
>   Does openvpn support any plug-in for viewing and modifying the payload
> to/from tunnel just before encryption and after decryption? I need to add
> some fields in the messages going to and coming from tunnel. I need this for
> both control and data messages.
> 
> I looked into 2.0_beta18 and didn't find any. I am planning to add such
> plug-in. The point I identified are:
> 
> for changing messages flowing to tunnel:
> 	In the beginning of method encrypt_sign. 
> 
> for changing messages flowing from tunnel:
> 	At the end of method process_incoming_link just before processing of
> ping and occ messages.
> 
> This is based on my assumption that all messages to tunnel are calling
> encrypt_sign method for encrypting the data. Do you have any plan to change
> the logic/name/location for these methods which may alter this assumption.

I think that's a reasonable assumption.  Note that if you plan on
increasing the packet length, then you will need to modify the struct
frame fields so that buffers will be sized correctly.

James


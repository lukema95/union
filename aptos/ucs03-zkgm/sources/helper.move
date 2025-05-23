
// License text copyright (c) 2020 MariaDB Corporation Ab, All Rights Reserved.
// "Business Source License" is a trademark of MariaDB Corporation Ab.

// Parameters

// Licensor:             Union.fi, Labs Inc.
// Licensed Work:        All files under https://github.com/unionlabs/union's aptos subdirectory
//                       The Licensed Work is (c) 2024 Union.fi, Labs Inc.
// Change Date:          Four years from the date the Licensed Work is published.
// Change License:       Apache-2.0
//

// For information about alternative licensing arrangements for the Licensed Work,
// please contact info@union.build.

// Notice

// Business Source License 1.1

// Terms

// The Licensor hereby grants you the right to copy, modify, create derivative
// works, redistribute, and make non-production use of the Licensed Work. The
// Licensor may make an Additional Use Grant, above, permitting limited production use.

// Effective on the Change Date, or the fourth anniversary of the first publicly
// available distribution of a specific version of the Licensed Work under this
// License, whichever comes first, the Licensor hereby grants you rights under
// the terms of the Change License, and the rights granted in the paragraph
// above terminate.

// If your use of the Licensed Work does not comply with the requirements
// currently in effect as described in this License, you must purchase a
// commercial license from the Licensor, its affiliated entities, or authorized
// resellers, or you must refrain from using the Licensed Work.

// All copies of the original and modified Licensed Work, and derivative works
// of the Licensed Work, are subject to this License. This License applies
// separately for each version of the Licensed Work and the Change Date may vary
// for each version of the Licensed Work released by Licensor.

// You must conspicuously display this License on each original or modified copy
// of the Licensed Work. If you receive the Licensed Work in original or
// modified form from a third party, the terms and conditions set forth in this
// License apply to your use of that work.

// Any use of the Licensed Work in violation of this License will automatically
// terminate your rights under this License for the current and all other
// versions of the Licensed Work.

// This License does not grant you any right in any trademark or logo of
// Licensor or its affiliates (provided that you may use a trademark or logo of
// Licensor as expressly required by this License).

// TO THE EXTENT PERMITTED BY APPLICABLE LAW, THE LICENSED WORK IS PROVIDED ON
// AN "AS IS" BASIS. LICENSOR HEREBY DISCLAIMS ALL WARRANTIES AND CONDITIONS,
// EXPRESS OR IMPLIED, INCLUDING (WITHOUT LIMITATION) WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, NON-INFRINGEMENT, AND
// TITLE.

module zkgm::zkgm_helpers {
    use ibc::packet::Packet;
    use std::copyable_any;

    struct RecvPacketParamsZKGM has copy, drop, store {
        packet: Packet,
        relayer: address,
        relayer_msg: vector<u8>
    }

    struct AcknowledgePacketParamsZKGM has copy, drop, store {
        packet: Packet,
        acknowledgement: vector<u8>,
        relayer: address
    }

    struct TimeoutPacketParamsZKGM has copy, drop, store {
        packet: Packet,
        relayer: address
    }

    public fun pack_acknowledge_packet_params_zkgm(
        packet: Packet, acknowledgement: vector<u8>, relayer: address
    ): copyable_any::Any {
        copyable_any::pack<AcknowledgePacketParamsZKGM>(
            AcknowledgePacketParamsZKGM { packet, acknowledgement, relayer }
        )
    }

    public fun pack_timeout_packet_params_zkgm(
        packet: Packet, relayer: address
    ): copyable_any::Any {
        copyable_any::pack<TimeoutPacketParamsZKGM>(
            TimeoutPacketParamsZKGM { packet, relayer }
        )
    }

    // Getter for RecvPacketParams
    public fun get_packet_from_recv_param_zkgm(
        param: &RecvPacketParamsZKGM
    ): &Packet {
        &param.packet
    }

    public fun get_relayer_from_recv_param_zkgm(
        param: &RecvPacketParamsZKGM
    ): address {
        param.relayer
    }

    public fun get_relayer_msg_from_recv_param_zkgm(
        param: &RecvPacketParamsZKGM
    ): &vector<u8> {
        &param.relayer_msg
    }

    // Getters for AcknowledgePacketParams
    public fun get_packet_from_ack_param_zkgm(
        param: &AcknowledgePacketParamsZKGM
    ): &Packet {
        &param.packet
    }

    public fun get_acknowledgement_from_ack_param_zkgm(
        param: &AcknowledgePacketParamsZKGM
    ): &vector<u8> {
        &param.acknowledgement
    }

    public fun get_relayer_from_ack_param_zkgm(
        param: &AcknowledgePacketParamsZKGM
    ): address {
        param.relayer
    }

    // Getter for TimeoutPacketParams
    public fun get_packet_from_timeout_param_zkgm(
        param: &TimeoutPacketParamsZKGM
    ): &Packet {
        &param.packet
    }

    public fun get_relayer_from_timeout_param_zkgm(
        param: &TimeoutPacketParamsZKGM
    ): address {
        param.relayer
    }

    public fun on_recv_packet_zkgm_deconstruct(
        recv_param: RecvPacketParamsZKGM
    ): (Packet, address, vector<u8>) {
        let pack = get_packet_from_recv_param_zkgm(&recv_param);
        let relayer = get_relayer_from_recv_param_zkgm(&recv_param);
        let relayer_msg = get_relayer_msg_from_recv_param_zkgm(&recv_param);
        (*pack, relayer, *relayer_msg)
    }

    public fun on_acknowledge_packet_deconstruct_zkgm(
        ack_param: AcknowledgePacketParamsZKGM
    ): (Packet, vector<u8>, address) {
        let pack = get_packet_from_ack_param_zkgm(&ack_param);
        let acknowledgement = get_acknowledgement_from_ack_param_zkgm(&ack_param);
        let relayer = get_relayer_from_ack_param_zkgm(&ack_param);
        (*pack, *acknowledgement, relayer)
    }

    public fun on_timeout_packet_deconstruct_zkgm(
        timeout_param: TimeoutPacketParamsZKGM
    ): (Packet, address) {
        let pack = get_packet_from_timeout_param_zkgm(&timeout_param);
        let relayer = get_relayer_from_timeout_param_zkgm(&timeout_param);
        (*pack, relayer)
    }
}

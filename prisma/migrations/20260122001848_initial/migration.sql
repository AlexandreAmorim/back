-- CreateTable
CREATE TABLE "users" (
    "id" TEXT NOT NULL,
    "user_id" UUID,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT,
    "document" TEXT NOT NULL,
    "document_secondary" TEXT,
    "function" TEXT,
    "war_name" TEXT,
    "rg" TEXT,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "phone" TEXT,
    "gender" TEXT,
    "birthday" DATE,
    "avatar" TEXT,
    "token" TEXT,
    "is_intelligence" BOOLEAN DEFAULT false,
    "status" BOOLEAN DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3),

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tokens" (
    "id" SERIAL NOT NULL,
    "token" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "is_revoked" BOOLEAN DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3),
    "user_id" TEXT NOT NULL,

    CONSTRAINT "tokens_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "permissions" (
    "id" SERIAL NOT NULL,
    "slug" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3),

    CONSTRAINT "permissions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "roles" (
    "id" SERIAL NOT NULL,
    "slug" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3),

    CONSTRAINT "roles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "permission_role" (
    "id" SERIAL NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "permission_id" INTEGER NOT NULL,
    "role_id" INTEGER NOT NULL,

    CONSTRAINT "permission_role_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "role_user" (
    "id" SERIAL NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "role_id" INTEGER NOT NULL,
    "user_id" TEXT NOT NULL,

    CONSTRAINT "role_user_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "addresses" (
    "id" SERIAL NOT NULL,
    "name" TEXT,
    "zip" TEXT,
    "street" TEXT,
    "number" TEXT,
    "complement" TEXT,
    "neighborhood" TEXT,
    "city" TEXT,
    "state" TEXT,
    "country" TEXT,
    "reference" TEXT,
    "latitude" DECIMAL(65,30),
    "longitude" DECIMAL(65,30),
    "user_id" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "addresses_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "managements" (
    "id" SERIAL NOT NULL,
    "level" TEXT,
    "name" TEXT NOT NULL,
    "initials" TEXT NOT NULL,
    "phone" TEXT,
    "is_core" BOOLEAN DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "user_id" TEXT NOT NULL,
    "address_id" INTEGER NOT NULL,
    "ascendant_id" INTEGER,
    "core_id" INTEGER,

    CONSTRAINT "managements_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "allocations" (
    "id" SERIAL NOT NULL,
    "started_at" TIMESTAMP(3) NOT NULL,
    "ended_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "management_id" INTEGER NOT NULL,
    "user_id" TEXT NOT NULL,
    "auth_id" TEXT,

    CONSTRAINT "allocations_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "settings" (
    "id" SERIAL NOT NULL,
    "version" TEXT,
    "profile_update_limit" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "managements_ids" TEXT,
    "cortex_status" BOOLEAN DEFAULT true,
    "cortex_token" TEXT,
    "cortex_status_person" BOOLEAN DEFAULT true,
    "cortex_token_person" TEXT,
    "cetic_status" BOOLEAN DEFAULT true,
    "cetic_token" TEXT,
    "sinalid_status" BOOLEAN DEFAULT true,
    "sinalid_token" TEXT,
    "sinalid_cookie" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "settings_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "sectors" (
    "id" SERIAL NOT NULL,
    "initials" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "status" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "management_id" INTEGER NOT NULL,
    "user_id" TEXT NOT NULL,

    CONSTRAINT "sectors_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "services" (
    "id" TEXT NOT NULL,
    "started_at" TIMESTAMP(3) NOT NULL,
    "ended_at" TIMESTAMP(3) NOT NULL,
    "presence_started_at" TIMESTAMP(3),
    "presence_ended_at" TIMESTAMP(3),
    "description" TEXT,
    "status" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "sector_id" INTEGER NOT NULL,
    "management_id" INTEGER NOT NULL,
    "user_id" TEXT NOT NULL,
    "auth_id" TEXT NOT NULL,
    "presence_started_id" TEXT,
    "presence_ended_id" TEXT,
    "missing_id" TEXT,

    CONSTRAINT "services_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "people" (
    "id" TEXT NOT NULL,
    "name" TEXT,
    "nickname" TEXT,
    "birthday" DATE,
    "year_birth" INTEGER,
    "gender" TEXT,
    "mather" TEXT,
    "father" TEXT,
    "phone" TEXT,
    "cell_phone" TEXT,
    "document" TEXT NOT NULL,
    "document_secondary" TEXT,
    "place_birth" TEXT,
    "description" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "user_id" TEXT,

    CONSTRAINT "people_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "vehicles" (
    "id" TEXT NOT NULL,
    "plate" TEXT NOT NULL,
    "chassi" TEXT NOT NULL,
    "color" TEXT,
    "brand" TEXT,
    "model" TEXT,
    "engine_number" TEXT,
    "description" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "user_id" TEXT,

    CONSTRAINT "vehicles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "situation_types" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "situation_types_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "results" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "conduction" BOOLEAN NOT NULL DEFAULT false,
    "type" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "user_id" TEXT NOT NULL,

    CONSTRAINT "results_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "systems" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "url" TEXT,
    "status" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "user_id" TEXT NOT NULL,

    CONSTRAINT "systems_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "orders" (
    "id" TEXT NOT NULL,
    "latitude" DECIMAL(65,30),
    "longitude" DECIMAL(65,30),
    "note" TEXT,
    "description" TEXT,
    "document" TEXT,
    "document_secondary" TEXT,
    "name" TEXT,
    "birthday" DATE,
    "mather" TEXT,
    "father" TEXT,
    "plate" TEXT,
    "chassi" TEXT,
    "type" TEXT,
    "status" TEXT,
    "color" TEXT,
    "brand" TEXT,
    "model" TEXT,
    "engine_number" TEXT,
    "placeBirth" TEXT,
    "gender" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "user_id" TEXT NOT NULL,
    "operator_id" TEXT,
    "vehicle_id" TEXT,
    "person_id" TEXT,
    "address_id" INTEGER,
    "management_id" INTEGER,
    "result_id" INTEGER,
    "sector_id" INTEGER,
    "service_id" TEXT,

    CONSTRAINT "orders_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "register_types" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "register_types_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "motives" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "motives_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "upajs" (
    "id" SERIAL NOT NULL,
    "initials" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "institution" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "addressId" INTEGER NOT NULL,

    CONSTRAINT "upajs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "end_situations" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "type" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "end_situations_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "closing_forms" (
    "id" TEXT NOT NULL,
    "register_number" TEXT,
    "description" TEXT,
    "status" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "user_id" TEXT NOT NULL,
    "order_id" TEXT NOT NULL,
    "management_id" INTEGER,
    "sector_id" INTEGER,
    "upaj_id" INTEGER,
    "address_id" INTEGER NOT NULL,
    "register_type_id" INTEGER,
    "end_situation_id" INTEGER,
    "motive_id" INTEGER,

    CONSTRAINT "closing_forms_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "assistances" (
    "id" SERIAL NOT NULL,
    "code" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "assistances_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "proximities" (
    "id" TEXT NOT NULL,
    "store" TEXT,
    "name" TEXT NOT NULL,
    "document" TEXT,
    "phone" TEXT,
    "email" TEXT,
    "cep" TEXT,
    "street" TEXT,
    "number" TEXT,
    "complement" TEXT,
    "distric" TEXT,
    "description" TEXT NOT NULL,
    "lat" INTEGER,
    "lng" INTEGER,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "assistance_id" INTEGER NOT NULL,
    "user_id" TEXT NOT NULL,
    "management_id" INTEGER NOT NULL,
    "sector_id" INTEGER,
    "service_id" TEXT,

    CONSTRAINT "proximities_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "make_cars" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "make_cars_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "model_cars" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "make_id" INTEGER,

    CONSTRAINT "model_cars_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "gases" (
    "id" SERIAL NOT NULL,
    "fantasy" TEXT,
    "corporate" TEXT,
    "cnpj" TEXT,
    "telephone" TEXT,
    "activity" TEXT,
    "address" TEXT,
    "district" TEXT,
    "city" TEXT,
    "state" TEXT,
    "cep" TEXT,
    "status" BOOLEAN,
    "latitude" INTEGER,
    "longitude" INTEGER,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "user_id" TEXT NOT NULL,

    CONSTRAINT "gases_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "fleets" (
    "id" TEXT NOT NULL,
    "order_number" TEXT,
    "plate" TEXT NOT NULL,
    "special_plate" TEXT,
    "color" TEXT,
    "type_vehicle" TEXT,
    "fuel" TEXT,
    "status_vehicle" BOOLEAN,
    "note" TEXT,
    "rental" TEXT,
    "user_id" TEXT NOT NULL,
    "management_id" INTEGER,
    "make_car_id" INTEGER NOT NULL,
    "model_car_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "fleets_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "bdtds" (
    "id" TEXT NOT NULL,
    "started_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "started_km" TEXT NOT NULL,
    "ended_at" TIMESTAMP(3),
    "ended_km" TEXT,
    "adm_id" UUID,
    "latitude_match" INTEGER,
    "longitude_match" INTEGER,
    "latitude_retreat" INTEGER,
    "longitude_retreat" INTEGER,
    "note" TEXT,
    "active" BOOLEAN,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "fleet_id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "management_id" INTEGER,
    "sector_id" INTEGER,
    "service_id" TEXT,

    CONSTRAINT "bdtds_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "fuelings" (
    "id" TEXT NOT NULL,
    "fuel" TEXT,
    "liters" DOUBLE PRECISION,
    "km_fueling" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "bdtd_id" TEXT NOT NULL,
    "fleet_id" TEXT NOT NULL,
    "gases_id" INTEGER NOT NULL,
    "user_id" TEXT NOT NULL,

    CONSTRAINT "fuelings_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "order_system" (
    "id" SERIAL NOT NULL,
    "order_id" TEXT NOT NULL,
    "system_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "order_system_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "people_occurences" (
    "id" TEXT NOT NULL,
    "name" VARCHAR,
    "birthday" DATE,
    "gender" VARCHAR,
    "mather" VARCHAR,
    "father" VARCHAR,
    "document" VARCHAR,
    "document_secondary" VARCHAR,
    "marital" VARCHAR,
    "email" INTEGER,
    "phone" VARCHAR,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "user_id" TEXT,

    CONSTRAINT "people_occurences_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "bopms" (
    "id" TEXT NOT NULL,
    "bopm_number" INTEGER,
    "service_team" VARCHAR NOT NULL,
    "origin_of_occurrence" VARCHAR,
    "type_of_registration" VARCHAR,
    "registration_number" VARCHAR,
    "type_of_warrant" VARCHAR,
    "history" TEXT,
    "is_finished" BOOLEAN,
    "school_environment" BOOLEAN,
    "others" VARCHAR,
    "sector" VARCHAR,
    "started_date_at" DATE,
    "started_time_at" TIME,
    "finish_date_at" DATE,
    "finish_time_at" TIME,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "user_id" TEXT NOT NULL,
    "management_id" INTEGER NOT NULL,
    "addresses_id" INTEGER NOT NULL,
    "upaj_id" INTEGER,

    CONSTRAINT "bopms_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "involveds" (
    "id" TEXT NOT NULL,
    "type_involvement" VARCHAR,
    "handcuffs" VARCHAR,
    "situation" VARCHAR,
    "qualified" VARCHAR,
    "created_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "user_id" TEXT NOT NULL,
    "bopm_id" TEXT NOT NULL,
    "people_occurrence_id" TEXT NOT NULL,

    CONSTRAINT "involveds_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "civil_polices" (
    "id" TEXT NOT NULL,
    "name" VARCHAR NOT NULL,
    "document" VARCHAR NOT NULL,
    "office_dp" VARCHAR NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "upaj_id" INTEGER NOT NULL,
    "bopm_id" TEXT NOT NULL,

    CONSTRAINT "civil_polices_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "involved_cars" (
    "id" TEXT NOT NULL,
    "motivation" VARCHAR,
    "plate" VARCHAR,
    "chassi" VARCHAR,
    "color" VARCHAR,
    "brand" VARCHAR,
    "model" VARCHAR,
    "conductor" VARCHAR,
    "exercise" VARCHAR,
    "crlv" VARCHAR,
    "cnh" VARCHAR,
    "category" VARCHAR,
    "uf" VARCHAR,
    "infringement" VARCHAR,
    "year" VARCHAR,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "bopm_id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "involved_id" TEXT,

    CONSTRAINT "involved_cars_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "seizures" (
    "id" TEXT NOT NULL,
    "brand" VARCHAR,
    "model" VARCHAR,
    "color" VARCHAR,
    "type" VARCHAR,
    "caliber" VARCHAR,
    "year" VARCHAR,
    "amount" VARCHAR,
    "measure" VARCHAR,
    "serial" VARCHAR,
    "plate" VARCHAR,
    "destiny" VARCHAR,
    "shaved" VARCHAR,
    "seizure_type" VARCHAR NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "bopm_id" TEXT NOT NULL,
    "involved_id" TEXT,
    "civil_police_id" TEXT,

    CONSTRAINT "seizures_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "logs" (
    "id" TEXT NOT NULL,
    "action" TEXT NOT NULL,
    "resource" TEXT NOT NULL,
    "method" TEXT NOT NULL,
    "path" TEXT NOT NULL,
    "ip" TEXT,
    "user_agent" VARCHAR,
    "status_code" INTEGER,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "user_id" TEXT,

    CONSTRAINT "logs_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_document_key" ON "users"("document");

-- CreateIndex
CREATE UNIQUE INDEX "users_document_secondary_key" ON "users"("document_secondary");

-- CreateIndex
CREATE UNIQUE INDEX "users_rg_key" ON "users"("rg");

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "tokens_token_key" ON "tokens"("token");

-- CreateIndex
CREATE UNIQUE INDEX "permissions_slug_key" ON "permissions"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "permissions_name_key" ON "permissions"("name");

-- CreateIndex
CREATE UNIQUE INDEX "roles_slug_key" ON "roles"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "roles_name_key" ON "roles"("name");

-- CreateIndex
CREATE UNIQUE INDEX "managements_name_key" ON "managements"("name");

-- CreateIndex
CREATE UNIQUE INDEX "managements_initials_key" ON "managements"("initials");

-- CreateIndex
CREATE UNIQUE INDEX "managements_ascendant_id_key" ON "managements"("ascendant_id");

-- CreateIndex
CREATE UNIQUE INDEX "managements_core_id_key" ON "managements"("core_id");

-- CreateIndex
CREATE UNIQUE INDEX "people_document_key" ON "people"("document");

-- CreateIndex
CREATE UNIQUE INDEX "people_document_secondary_key" ON "people"("document_secondary");

-- CreateIndex
CREATE INDEX "people_document_document_secondary_idx" ON "people"("document", "document_secondary");

-- CreateIndex
CREATE UNIQUE INDEX "vehicles_plate_key" ON "vehicles"("plate");

-- CreateIndex
CREATE UNIQUE INDEX "vehicles_chassi_key" ON "vehicles"("chassi");

-- CreateIndex
CREATE INDEX "vehicles_plate_chassi_idx" ON "vehicles"("plate", "chassi");

-- CreateIndex
CREATE UNIQUE INDEX "situation_types_name_key" ON "situation_types"("name");

-- CreateIndex
CREATE UNIQUE INDEX "results_name_key" ON "results"("name");

-- CreateIndex
CREATE UNIQUE INDEX "systems_name_key" ON "systems"("name");

-- CreateIndex
CREATE INDEX "systems_name_idx" ON "systems"("name");

-- CreateIndex
CREATE UNIQUE INDEX "fleets_plate_key" ON "fleets"("plate");

-- CreateIndex
CREATE UNIQUE INDEX "fleets_special_plate_key" ON "fleets"("special_plate");

-- AddForeignKey
ALTER TABLE "tokens" ADD CONSTRAINT "tokens_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "permission_role" ADD CONSTRAINT "permission_role_permission_id_fkey" FOREIGN KEY ("permission_id") REFERENCES "permissions"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "permission_role" ADD CONSTRAINT "permission_role_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "roles"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "role_user" ADD CONSTRAINT "role_user_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "roles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "role_user" ADD CONSTRAINT "role_user_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "managements" ADD CONSTRAINT "managements_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "managements" ADD CONSTRAINT "managements_address_id_fkey" FOREIGN KEY ("address_id") REFERENCES "addresses"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "managements" ADD CONSTRAINT "managements_ascendant_id_fkey" FOREIGN KEY ("ascendant_id") REFERENCES "managements"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "managements" ADD CONSTRAINT "managements_core_id_fkey" FOREIGN KEY ("core_id") REFERENCES "managements"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "allocations" ADD CONSTRAINT "allocations_management_id_fkey" FOREIGN KEY ("management_id") REFERENCES "managements"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "allocations" ADD CONSTRAINT "allocations_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "allocations" ADD CONSTRAINT "allocations_auth_id_fkey" FOREIGN KEY ("auth_id") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sectors" ADD CONSTRAINT "sectors_management_id_fkey" FOREIGN KEY ("management_id") REFERENCES "managements"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sectors" ADD CONSTRAINT "sectors_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "services" ADD CONSTRAINT "services_sector_id_fkey" FOREIGN KEY ("sector_id") REFERENCES "sectors"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "services" ADD CONSTRAINT "services_management_id_fkey" FOREIGN KEY ("management_id") REFERENCES "managements"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "services" ADD CONSTRAINT "services_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "services" ADD CONSTRAINT "services_auth_id_fkey" FOREIGN KEY ("auth_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "services" ADD CONSTRAINT "services_presence_started_id_fkey" FOREIGN KEY ("presence_started_id") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "services" ADD CONSTRAINT "services_presence_ended_id_fkey" FOREIGN KEY ("presence_ended_id") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "services" ADD CONSTRAINT "services_missing_id_fkey" FOREIGN KEY ("missing_id") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "people" ADD CONSTRAINT "people_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "vehicles" ADD CONSTRAINT "vehicles_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "results" ADD CONSTRAINT "results_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "systems" ADD CONSTRAINT "systems_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "orders" ADD CONSTRAINT "orders_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "orders" ADD CONSTRAINT "orders_operator_id_fkey" FOREIGN KEY ("operator_id") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "orders" ADD CONSTRAINT "orders_vehicle_id_fkey" FOREIGN KEY ("vehicle_id") REFERENCES "vehicles"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "orders" ADD CONSTRAINT "orders_person_id_fkey" FOREIGN KEY ("person_id") REFERENCES "people"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "orders" ADD CONSTRAINT "orders_address_id_fkey" FOREIGN KEY ("address_id") REFERENCES "addresses"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "orders" ADD CONSTRAINT "orders_management_id_fkey" FOREIGN KEY ("management_id") REFERENCES "managements"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "orders" ADD CONSTRAINT "orders_result_id_fkey" FOREIGN KEY ("result_id") REFERENCES "results"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "orders" ADD CONSTRAINT "orders_sector_id_fkey" FOREIGN KEY ("sector_id") REFERENCES "sectors"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "orders" ADD CONSTRAINT "orders_service_id_fkey" FOREIGN KEY ("service_id") REFERENCES "services"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "upajs" ADD CONSTRAINT "upajs_addressId_fkey" FOREIGN KEY ("addressId") REFERENCES "addresses"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "closing_forms" ADD CONSTRAINT "closing_forms_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "closing_forms" ADD CONSTRAINT "closing_forms_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "orders"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "closing_forms" ADD CONSTRAINT "closing_forms_management_id_fkey" FOREIGN KEY ("management_id") REFERENCES "managements"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "closing_forms" ADD CONSTRAINT "closing_forms_sector_id_fkey" FOREIGN KEY ("sector_id") REFERENCES "sectors"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "closing_forms" ADD CONSTRAINT "closing_forms_upaj_id_fkey" FOREIGN KEY ("upaj_id") REFERENCES "upajs"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "closing_forms" ADD CONSTRAINT "closing_forms_address_id_fkey" FOREIGN KEY ("address_id") REFERENCES "addresses"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "closing_forms" ADD CONSTRAINT "closing_forms_register_type_id_fkey" FOREIGN KEY ("register_type_id") REFERENCES "register_types"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "closing_forms" ADD CONSTRAINT "closing_forms_end_situation_id_fkey" FOREIGN KEY ("end_situation_id") REFERENCES "end_situations"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "closing_forms" ADD CONSTRAINT "closing_forms_motive_id_fkey" FOREIGN KEY ("motive_id") REFERENCES "motives"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "proximities" ADD CONSTRAINT "proximities_assistance_id_fkey" FOREIGN KEY ("assistance_id") REFERENCES "assistances"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "proximities" ADD CONSTRAINT "proximities_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "proximities" ADD CONSTRAINT "proximities_management_id_fkey" FOREIGN KEY ("management_id") REFERENCES "managements"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "proximities" ADD CONSTRAINT "proximities_sector_id_fkey" FOREIGN KEY ("sector_id") REFERENCES "sectors"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "proximities" ADD CONSTRAINT "proximities_service_id_fkey" FOREIGN KEY ("service_id") REFERENCES "services"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "model_cars" ADD CONSTRAINT "model_cars_make_id_fkey" FOREIGN KEY ("make_id") REFERENCES "make_cars"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "gases" ADD CONSTRAINT "gases_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "fleets" ADD CONSTRAINT "fleets_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "fleets" ADD CONSTRAINT "fleets_management_id_fkey" FOREIGN KEY ("management_id") REFERENCES "managements"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "fleets" ADD CONSTRAINT "fleets_make_car_id_fkey" FOREIGN KEY ("make_car_id") REFERENCES "make_cars"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "fleets" ADD CONSTRAINT "fleets_model_car_id_fkey" FOREIGN KEY ("model_car_id") REFERENCES "model_cars"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bdtds" ADD CONSTRAINT "bdtds_fleet_id_fkey" FOREIGN KEY ("fleet_id") REFERENCES "fleets"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bdtds" ADD CONSTRAINT "bdtds_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bdtds" ADD CONSTRAINT "bdtds_management_id_fkey" FOREIGN KEY ("management_id") REFERENCES "managements"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bdtds" ADD CONSTRAINT "bdtds_sector_id_fkey" FOREIGN KEY ("sector_id") REFERENCES "sectors"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bdtds" ADD CONSTRAINT "bdtds_service_id_fkey" FOREIGN KEY ("service_id") REFERENCES "services"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "fuelings" ADD CONSTRAINT "fuelings_bdtd_id_fkey" FOREIGN KEY ("bdtd_id") REFERENCES "bdtds"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "fuelings" ADD CONSTRAINT "fuelings_fleet_id_fkey" FOREIGN KEY ("fleet_id") REFERENCES "fleets"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "fuelings" ADD CONSTRAINT "fuelings_gases_id_fkey" FOREIGN KEY ("gases_id") REFERENCES "gases"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "fuelings" ADD CONSTRAINT "fuelings_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "order_system" ADD CONSTRAINT "order_system_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "orders"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "order_system" ADD CONSTRAINT "order_system_system_id_fkey" FOREIGN KEY ("system_id") REFERENCES "systems"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "people_occurences" ADD CONSTRAINT "people_occurences_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bopms" ADD CONSTRAINT "bopms_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bopms" ADD CONSTRAINT "bopms_management_id_fkey" FOREIGN KEY ("management_id") REFERENCES "managements"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bopms" ADD CONSTRAINT "bopms_addresses_id_fkey" FOREIGN KEY ("addresses_id") REFERENCES "addresses"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bopms" ADD CONSTRAINT "bopms_upaj_id_fkey" FOREIGN KEY ("upaj_id") REFERENCES "upajs"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "involveds" ADD CONSTRAINT "involveds_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "involveds" ADD CONSTRAINT "involveds_bopm_id_fkey" FOREIGN KEY ("bopm_id") REFERENCES "bopms"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "involveds" ADD CONSTRAINT "involveds_people_occurrence_id_fkey" FOREIGN KEY ("people_occurrence_id") REFERENCES "people_occurences"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "civil_polices" ADD CONSTRAINT "civil_polices_upaj_id_fkey" FOREIGN KEY ("upaj_id") REFERENCES "upajs"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "civil_polices" ADD CONSTRAINT "civil_polices_bopm_id_fkey" FOREIGN KEY ("bopm_id") REFERENCES "bopms"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "involved_cars" ADD CONSTRAINT "involved_cars_bopm_id_fkey" FOREIGN KEY ("bopm_id") REFERENCES "bopms"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "involved_cars" ADD CONSTRAINT "involved_cars_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "involved_cars" ADD CONSTRAINT "involved_cars_involved_id_fkey" FOREIGN KEY ("involved_id") REFERENCES "involveds"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "seizures" ADD CONSTRAINT "seizures_bopm_id_fkey" FOREIGN KEY ("bopm_id") REFERENCES "bopms"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "seizures" ADD CONSTRAINT "seizures_involved_id_fkey" FOREIGN KEY ("involved_id") REFERENCES "involveds"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "seizures" ADD CONSTRAINT "seizures_civil_police_id_fkey" FOREIGN KEY ("civil_police_id") REFERENCES "civil_polices"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "logs" ADD CONSTRAINT "logs_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;
